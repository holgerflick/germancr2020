unit Forms.Details;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, Modules.Data,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, AdvSplitter, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart;

type
  TFrmDetail = class(TForm)
    Grid: TAdvStringGrid;
    QuNumbers: TFDQuery;
    AdvSplitter1: TAdvSplitter;
    Chart: TChart;
    serCases: TBarSeries;
    serDeaths: TBarSeries;
    QuCoordinates: TFDQuery;
    serNewCases: TBarSeries;
    serNewDeaths: TBarSeries;
  private
    FCoordId: Integer;
    procedure SetCoordId(const Value: Integer);

    procedure LoadData;
    { Private declarations }
  public
    { Public declarations }
    property CoordId: Integer read FCoordId write SetCoordId;
  end;

var
  FrmDetail: TFrmDetail;

implementation

{$R *.dfm}

{ TFrmDetail }

procedure TFrmDetail.LoadData;
var
  LRow: Integer;
  LDeltaCases,
  LDeltaDeaths,
  LLastDeaths,
  LLastCases : Integer;
begin
  QuCoordinates.Close;

  QuCoordinates.ParamByName('Id').AsInteger := CoordId;
  QuCoordinates.Open;

  QuNumbers.Close;
  QuNumbers.ParamByName('state').AsString := QuCoordinates['state'];
  QuNumbers.ParamByName('county').AsString := QuCoordinates['county'];
  QuNumbers.Open;

  self.Caption := Format( 'Detail data: %s County, %s',
    [ QuCoordinates['county'],
      QuCoordinates['state']
    ] );

  Grid.BeginUpdate;
  try
    Grid.RowCount := QuNumbers.RecordCount +1;

    Grid.Cells[0,0] := 'Date';
    Grid.Cells[1,0] := 'Cases';
    Grid.Cells[2,0] := '+/-';
    Grid.Cells[3,0] := 'Deaths';
    Grid.Cells[4,0] := '+/-';

    LRow := 0;

    LLastDeaths := 0;
    LLastCases := 0;

    serCases.BeginUpdate;
    serCases.Clear;

    serDeaths.BeginUpdate;
    serDeaths.Clear;

    while not QuNumbers.Eof do
    begin
      Inc( LRow );

      LDeltaCases := QuNumbers['Cases'] - LLastCases;
      LDeltaDeaths := QuNumbers['Deaths'] - LLastDeaths;

      Grid.Dates[0,LRow] := QuNumbers['Date'];
      Grid.AllInts[1,LRow] := QuNumbers['Cases'];
      Grid.AllInts[2,LRow] := LDeltaCases;
      Grid.AllInts[3,LRow] := QuNumbers['Deaths'] ;
      Grid.AllInts[4,LRow] := LDeltaDeaths;

      serCases.AddXY( QuNumbers['Date'], QuNumbers['Cases']);
      serDeaths.AddXY( QuNumbers['Date'], QuNumbers['Deaths'] );

      serNewCases.AddXY( QuNumbers['Date'], LDeltaCases);
      serNewDeaths.AddXY( QuNumbers['Date'], LDeltaDeaths );

      LLastCases := QuNumbers['Cases'];
      LLastDeaths :=QuNumbers['Deaths'];

      QuNumbers.Next;
    end;

    Grid.Sort(0, sdDescending);

    Grid.AutoFitColumns(true);

  finally
    serDeaths.EndUpdate;
    serCases.EndUpdate;
    Grid.EndUpdate;
  end;
end;

procedure TFrmDetail.SetCoordId(const Value: Integer);
begin
  FCoordId := Value;

  LoadData;
end;

end.
