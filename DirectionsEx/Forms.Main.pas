unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps, Vcl.StdCtrls, AdvEdit, AdvMemo, AdvGlowButton, VCL.TMSFNCCustomComponent,
  VCL.TMSFNCCloudBase, VCL.TMSFNCDirections, VCL.TMSFNCGeocoding, Vcl.ExtCtrls, AdvSplitter,
  AdvStyleIF, AdvAppStyler;

type
  TFrmMain = class(TForm)
    Map: TTMSFNCMaps;
    Directions: TTMSFNCDirections;
    Geocoding: TTMSFNCGeocoding;
    Panel1: TPanel;
    txtInfo: TAdvMemo;
    btnCosts: TAdvGlowButton;
    btnReport: TAdvGlowButton;
    txtCustomer: TAdvEdit;
    AdvSplitter1: TAdvSplitter;
    FormStyler: TAdvFormStyler;
    dlgSave: TFileSaveDialog;
    procedure btnCostsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GeocodingGetGeocoding(Sender: TObject; const ARequest: TTMSFNCGeocodingRequest;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure DirectionsGetDirections(Sender: TObject; const ARequest: TTMSFNCDirectionsRequest;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure btnReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCustomerCoords,
    FHomeCoords: TTMSFNCMapsCoordinateRec;

    procedure UpdateRoute;

    procedure GeocodeHome;
    procedure GeoCodeCustomer;

    procedure AddInfo( AText: String; ASpace : Boolean = False);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  IOUtils,
  Modules.Reporting;

const
  ADDR_HOME = 'Südliche Ringstraße 175, 63225 Langen, Germany';


procedure TFrmMain.AddInfo(AText: String; ASpace : Boolean = False);
begin
//  txtInfo.Lines.Add( DateTimeToStr(Now) );
  txtInfo.Lines.Add( AText );
  if ASpace then
  begin
    txtInfo.Lines.Add('');
  end;
end;

procedure TFrmMain.btnCostsClick(Sender: TObject);
begin
  GeocodeCustomer;
end;

procedure TFrmMain.btnReportClick(Sender: TObject);
var
  LMem: TMemoryStream;

begin
  if dlgSave.Execute then
  begin
    LMem := Reporting.AsPDF;
    if Assigned( LMem ) then
    begin
      LMem.SaveToFile(dlgSave.FileName);
      TTMSFNCUtils.OpenFile(dlgSave.FileName);
      LMem.Free;
    end;
  end;
end;

procedure TFrmMain.DirectionsGetDirections(Sender: TObject;
  const ARequest: TTMSFNCDirectionsRequest; const ARequestResult: TTMSFNCCloudBaseRequestResult);
var
  LItem: TTMSFNCDirectionsItem;
  s, i: Integer;

  LPoly: TTMSFNCMapsPolyline;
  LInstr: String;

  LStep: TTMSFNCDirectionsStep;
  LLine : Integer;

begin
  Map.BeginUpdate;
  try
    Reporting.Clear;
    Reporting.CustomerAddress := txtCustomer.Text;

    LLine := 0;

    for i := 0 to ARequest.Items.Count -1 do
    begin
      LItem := ARequest.Items[i];

      LPoly := Map.AddPolyline( LItem.Coordinates.ToArray );
      LPoly.StrokeColor := clRed;
      LPoly.StrokeOpacity := 0.5;
      LPoly.StrokeWidth := 3;

      for s := 0 to LItem.Steps.Count -1 do
      begin
        LStep := LItem.Steps[s];

        LInstr := TTMSFNCUtils.HTMLStrip( LStep.Instructions.Replace('<div','. <div' ) );
        Inc( LLine );
        Reporting.AddStep(LLine, LInstr, LStep.Distance, LStep.Duration);

//        AddInfo( Format( '%3d %s ', [ s,
//          LInstr ] ) );
//        AddInfo( Format( '    %.1f min, %.1f km', [ LStep.Duration / 60, LStep.Distance/1000] ), True );
      end;
    end;

    AddInfo( Format( 'Distance: %f km', [ Reporting.TotalDistance/1000 ] ) );
    AddInfo( Format( 'Duration: %f minutes', [ Reporting.TotalDuration/60 ] ), True );


    AddInfo( '  (duration charged in half hour intervals)', True);

    AddInfo( Format( 'Cost time (%3d units for %6.2m) : %8.2m',
      [ Reporting.HalfHours, Reporting.CostHalfHour, Reporting.CostDuration ] ) );
    AddInfo( Format( 'Cost distance (%3d km for %6.2m): %8.2m',
      [ Reporting.TotalDistanceKm, Reporting.RatePerKm, Reporting.CostDistance ] ) );
    AddInfo( '------------------------------------------------------' );
    AddInfo( Format( 'Total cost                       : %8.2m',
      [ Reporting.CostDistance + Reporting.CostDuration ] ) );

    // zoom map to area showing origin and destination
    Map.ZoomToBounds(Map.Polylines.ToCoordinateArray);

    // add marker for origin
    Map.Markers.Clear;
    Map.AddMarker( FHomeCoords, 'Start' );

    // add marker for destination
    Map.AddMarker( FCustomerCoords, 'Destination' );

    btnReport.Enabled := True;
  finally
    Map.EndUpdate;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);

begin
  // TODO: assign keys
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  txtInfo.Lines.Clear;
  btnReport.Enabled := False;

  GeocodeHome;
end;

procedure TFrmMain.GeoCodeCustomer;
begin
  Geocoding.GetGeocoding( txtCustomer.Text, nil, 'Customer' );
end;

procedure TFrmMain.GeocodeHome;
begin
  Geocoding.GetGeocoding( ADDR_HOME, nil, 'Home' );
end;

procedure TFrmMain.GeocodingGetGeocoding(Sender: TObject; const ARequest: TTMSFNCGeocodingRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
var
  LItem: TTMSFNCGeocodingItem;
  i : Integer;
begin
  for i := 0 to ARequest.Items.Count -1 do
  begin
    LItem := ARequest.Items[i];

    if ARequest.ID = 'Home' then
    begin
      // coordinates for home address
      FHomeCoords := LItem.Coordinate.ToRec;

      AddInfo(  Format(
        'Home coordinates determined (%f|%f)',
        [ FHomeCoords.Latitude, FHomeCoords.Longitude ] ), True
        );
    end;

    if ARequest.ID = 'Customer' then
    begin
      // coordinates for customer address
      FCustomerCoords := LItem.Coordinate.ToRec;

      AddInfo(  Format(
        'Customer coordinates determined (%f|%f)',
        [ FCustomerCoords.Latitude, FCustomerCoords.Longitude ] ), True
        );

      UpdateRoute;
    end;
  end;
end;

procedure TFrmMain.UpdateRoute;
begin
  if ( FHomeCoords.Longitude <> 0 ) AND
    ( FCustomerCoords.Longitude <> 0 ) then
  begin
    Directions.DirectionsRequests.Clear;
    Directions.GetDirections(FHomeCoords, FCustomerCoords );
  end;
end;

end.
