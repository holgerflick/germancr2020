unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.ExtCtrls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  DBAdvGrid, Modules.Data, Data.DB, Vcl.StdCtrls, VCL.TMSFNCCustomComponent, VCL.TMSFNCCloudBase,
  VCL.TMSFNCGeocoding, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps, Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, AdvCombo, AdvStyleIF, AdvAppStyler,
  Modules.Resources, AdvGlowButton, AdvToolBar;

type
  TFrmMain = class(TForm)
    Map: TTMSFNCMaps;
    AdvFormStyler1: TAdvFormStyler;
    Geocoder: TTMSFNCGeocoding;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btnGeocode: TAdvGlowButton;
    btnSelectState: TAdvGlowButton;
    btnAbout: TAdvGlowButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    procedure FormCreate(Sender: TObject);

    procedure MapPolyElementClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
    procedure GeocoderRequestsComplete(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnSelectStateClick(Sender: TObject);
    procedure btnGeocodeClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentState : String;

    procedure StartGeocoding( AState, ACounty: String );
    procedure Calculate;

    procedure ShowData( AState: String );
    procedure ShowDetails( AId: Integer );

    procedure UpdateProgress;
    procedure OnCancelGeocoding(Sender: TObject );

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  IOUtils,
  Threading,
  Forms.Details,
  Forms.Progress,
  Forms.SelectState,
  Forms.About;

procedure TFrmMain.btnAboutClick(Sender: TObject);
var
  LFrm: TFrmAbout;

begin
  LFrm := TFrmAbout.Create(nil);
  try
    LFrm.ShowModal;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmMain.btnGeocodeClick(Sender: TObject);
begin
  Calculate;
end;

procedure TFrmMain.btnSelectStateClick(Sender: TObject);
var
  LFrm: TFrmSelectState;
  LState : String;

begin
  LFrm := TFrmSelectState.Create(nil);
  try
    LState := LFrm.SelectState( FCurrentState );
    if LState <> '' then
    begin
      FCurrentState := LState;
      ShowData(LState);
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TFrmMain.Calculate;
var
  LCounties: TStringlist;

  LQuCounties: TDataSet;
  LQuCoords : TDataSet;
  LState,
  LCounty: String;
  i: Integer;
  LSplits: TArray<string>;

begin

  LCounties := TStringlist.Create;
  try
    LQuCounties := DBController.QuCounties;
    LQuCoords := DBController.QuCoordinates;

    LQuCoords.DisableControls;
    LQuCounties.DisableControls;

    LQuCoords.Open;
    try
      LQuCounties.First;
      while not LQuCounties.Eof do
      begin
        LState := LQuCounties.FieldByName('State').AsString;
        LCounty := LQuCounties.FieldByName('County').AsString;

        if LCounty.ToLower <> 'unknown' then
        begin
          // find county in coordinates
          if not LQuCoords.Locate( 'State;County',
            VarArrayOf( [LState, LCounty] ), [] ) then
          begin
            // not found, add to list
            LCounties.Add( LState + '|' + LCounty );
          end;
        end;

        LQuCounties.Next;
      end;
   finally
      LQuCoords.EnableControls;
      LQuCounties.EnableControls;
    end;

    LQuCoords.Close;

    if LCounties.Count > 0 then
    begin
      if MessageDlg( Format( '%d counties need to be updated.' +
        'Do you want to continue?',
        [ LCounties.Count ] ), mtConfirmation, [mbYes,mbNo], 0 ) = mrYes then
      begin
        FrmProgress.Start( 'Geocoding counties...', LCounties.Count);

        // issue geocoding for all items in list
        for i := 0 to LCounties.Count -1 do
        begin
          LSplits := LCounties[i].Split(['|']);
          LState := LSplits[0];
          LCounty := LSplits[1];

          StartGeocoding( LState, LCounty );
        end;
      end;
    end
    else
    begin
      MessageDlg( 'No updates needed.', mtInformation, [mbOK], 0 );
    end;

  finally
    LCounties.Free;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
   // TODO: assign keys!
end;

procedure TFrmMain.GeocoderRequestsComplete(Sender: TObject);
begin
  FrmProgress.Close;
end;


procedure TFrmMain.MapPolyElementClick(Sender: TObject; AEventData: TTMSFNCMapsEventData);
begin
  ShowDetails( AEventData.PolyElement.DataInteger );
end;

procedure TFrmMain.OnCancelGeocoding(Sender: TObject);
begin
  TThread.Synchronize( nil,
    procedure
    var
      LReq: TTMSFNCCloudBaseRequest;

    begin
      for LReq in Geocoder.RunningRequests do
      begin

      end;
    end
  );
end;


procedure TFrmMain.ShowData(AState: String);
var
  LQuery: TFDQuery;
  LQuNumbers: TFDQuery;

begin
  LQuery := TFDQuery.Create(nil);
  LQuNumbers := TFDQuery.Create( nil );

  Map.BeginUpdate;
  try
    LQuNumbers.Connection := DBController.Connection;
    LQuNumbers.SQL.Text := 'SELECT * FROM counties WHERE state = :state ' +
                           'AND county = :county ORDER BY date DESC LIMIT 1';

    LQuery.Connection := DBController.Connection;
    LQuery.SQL.Text := 'SELECT * FROM coordinates where state = :state';
    LQuery.ParamByName('state').AsString := AState;

    LQuery.Open;

    Map.Clear;

    while not LQuery.Eof do
    begin
      LQuNumbers.ParamByName('state').AsString := LQuery['state'];
      LQuNumbers.ParamByName('county').AsString := LQuery['county'];
      LQuNumbers.Open;

      var LCircle := Map.AddCircle(
        CreateCoordinate( LQuery['Lat'], LQuery['Lon'] ),
        LQuNumbers['cases'] * 2
      );

      LCircle.FillColor := clNavy;
      LCircle.FillOpacity := 0.3;
      LCircle.StrokeColor := clBlue;
      LCircle.StrokeOpacity := 0.5;
      LCircle.StrokeWidth := 1;
      LCircle.DataInteger := LQuery['Id'];

//      Map.AddMarker(
//       CreateCoordinate( LQuery['Lat'], LQuery['Lon'] )
//      );

      LQuNumbers.Close;

      LQuery.Next;
    end;

    Map.ZoomToBounds( Map.Circles.ToCoordinateArray );
  finally
    LQuNumbers.Free;
    LQuery.Free;
    Map.EndUpdate;
  end;
end;


procedure TFrmMain.ShowDetails(AId: Integer);
var
  LFrm : TFrmDetail;

begin
  LFrm := TFrmDetail.Create(self);

  try
    LFrm.CoordId := AId;
    LFrm.Show;
  finally

  end;
end;

procedure TFrmMain.StartGeocoding(AState, ACounty: String);
begin
  Geocoder.GetGeocoding( ACounty + ' County,' + AState + ',USA',
    procedure (const ARequest: TTMSFNCGeocodingRequest;
               const ARequestResult: TTMSFNCCloudBaseRequestResult)
    var
      i : Integer;
      LItem: TTMSFNCGeocodingItem;
      LSplits: TArray<string>;
      LState: String;
      LCounty: String;
      LCoord: TTMSFNCMapsCoordinateRec;
      LQuery : TFDQuery;

    begin
      UpdateProgress;

      if ARequestResult.Success then
      begin
        LQuery := TFDQuery.Create(nil);
        LQuery.Connection := DBController.Connection;
        try
          if ARequest.Items.Count > 0 then
          begin
            LItem := ARequest.Items[0];
            LSplits := ARequest.ID.Split(['|']);
            LState := LSplits[0];
            LCounty := LSplits[1];

            LCoord := LItem.Coordinate.ToRec;

            LQuery.SQL.Text := 'INSERT INTO coordinates (  State, County, Lat, Lon ) ' +
                               'VALUES ( :State, :County, :Lat, :Lon )';

            LQuery.ParamByName('State').AsString := LState;
            LQuery.ParamByName('County').AsString := LCounty;
            LQuery.ParamByName('Lat').AsFloat := LCoord.Latitude;
            LQuery.ParamByName('Lon').AsFloat := LCoord.Longitude;
            LQuery.ExecSQL;
          end;
        finally

        end;
      end;
    end,
    AState + '|' + ACounty
  );
end;

procedure TFrmMain.UpdateProgress;
begin
TThread.Synchronize( nil,
  procedure
  begin
    FrmProgress.UpdateProgress( Geocoder.RunningRequests.Count );
  end);
end;

end.
