unit Modules.Reporting;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TReportStep = class
  strict private
    FLine: Integer;
    FInstruction: String;
    FDistance: Double;
    FDuration: Integer;
  private
    function GetDistanceKm: Double;
    function GetDurationMin: Double;

  public
    property Line: Integer read FLine write FLine;
    property Instruction: String read FInstruction write FInstruction;
    property Distance: Double read FDistance write FDistance;
    property Duration: Integer read FDuration write FDuration;
    property DurationMin: Double read GetDurationMin;
    property DistanceKm: Double read GetDistanceKm;
  end;

type
  TReporting = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCustomerAddress: String;
  
    FSteps: TObjectList<TReportStep>;
    FRatePerHour: Double;
    FRatePerKm: Double;

    function GetCostDriving: Double;
    function GetCostDuration: Double;
    function GetTotalDistance: Double;
    function GetTotalDuration: Integer;
    function GetCostHalfHour: Double;
    function GetHalfHours: Integer;
    function GetTotalDistanceKm: Integer;


    { Private declarations }
  public
    { Public declarations }
    procedure Clear;
    procedure AddStep( ALine: Integer; AInstruction: String;
      ADistance:Double; ADuration:Integer );

    function AsPDF: TMemoryStream;

    property Steps: TObjectList<TReportStep> read FSteps;
    property TotalDuration: Integer read GetTotalDuration;
    property TotalDistance: Double read GetTotalDistance;
    property CostDuration: Double read GetCostDuration;
    property CostDistance: Double read GetCostDriving;
    property CustomerAddress: String read FCustomerAddress write FCustomerAddress;
    property TotalDistanceKm : Integer read GetTotalDistanceKm;
    property HalfHours : Integer read GetHalfHours;
    property CostHalfHour : Double read GetCostHalfHour;
    property RatePerHour: Double read FRatePerHour write FRatePerHour;
    property RatePerKm: Double read FRatePerKm write FRatePerKm;
  end;

var
  Reporting: TReporting;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  System.IOUtils,
  VCL.FlexCel.Core,
  TMSFNCUtils,
  FlexCel.XlsAdapter,
  FlexCel.Render,
  FlexCel.Report,
  FlexCel.PDF;

{ TReporting }

procedure TReporting.AddStep(ALine: Integer; AInstruction: String; ADistance: Double;
  ADuration: Integer);
var
  LItem: TReportStep;

begin
  LItem := TReportStep.Create;
  LItem.Line := ALine;
  LItem.Instruction := AInstruction;
  LItem.Distance := ADistance;
  LItem.Duration := ADuration;

  Steps.Add(LItem);
end;

function TReporting.AsPDF: TMemoryStream;
var
  LReport : TFlexCelReport;

  LResource: TResourceStream;

  LTemplate: TMemoryStream;
  LOutput: TMemoryStream;
  LXlsFile: TXlsFile;
  LPdf: TFlexCelPdfExport;

begin
  LReport := TFlexCelReport.Create;
  LTemplate := TMemoryStream.Create;
  LXlsFile := TXlsFile.Create;
  LOutput := TMemoryStream.Create;
  LPdf := TFlexCelPdfExport.Create;
  try
    LResource := TTMSFNCUtils.GetResourceStream('Report');

    LTemplate.LoadFromStream( LResource );
    LTemplate.Position := 0;

    LReport.SetValue('CustomerAddr', self.CustomerAddress );
    LReport.SetValue('TotalDuration', Format( '%d min', [self.TotalDuration DIV 60]) );
    LReport.SetValue('TotalDistance', Format( '%d km', [self.TotalDistanceKm]) );
    LReport.SetValue('CostDuration', Format( '%m', [CostDuration] ));
    LReport.SetValue('CostDistance', Format( '%m', [CostDistance] ));
    LReport.SetValue('CostTotal', Format( '%m', [CostDuration + CostDistance] ));
    LReport.AddTable<TReportStep>('Q', Steps);
    LReport.Run(LTemplate, LOutput);

    LPdf.Workbook := LXlsFile;

    LOutput.Position := 0;
    LPdf.Workbook.Open(LOutput);

    Result := TMemoryStream.Create;
    LPdf.Export(Result);
  finally
    LPdf.Free;
    LOutput.Free;
    LXlsFile.Free;
    LTemplate.Free;
    LReport.Free;
    LResource.Free;
  end;
end;

procedure TReporting.Clear;
begin
  Steps.Clear;
end;

procedure TReporting.DataModuleCreate(Sender: TObject);
begin
  FSteps := TObjectList<TReportStep>.Create;

  FRatePerHour := 100.0;
  FRatePerKm := 0.5;
end;

procedure TReporting.DataModuleDestroy(Sender: TObject);
begin
  FSteps.Free;
end;

function TReporting.GetCostDriving: Double;
begin
  Result := ( TotalDistanceKm ) * RatePerKm;
end;

function TReporting.GetCostDuration: Double;
begin
  Result := CostHalfHour * HalfHours;
end;

function TReporting.GetCostHalfHour: Double;
begin
  Result := RatePerHour / 2;
end;

function TReporting.GetHalfHours: Integer;
begin
  Result := ( TRUNC( TotalDuration/60/60 ) + 1) * 2;
end;

function TReporting.GetTotalDistance: Double;
var
  LItem: TReportStep;

begin
  Result := 0;
  for LItem in Steps do
  begin
    Result := Result + LItem.Distance;
  end;
end;

function TReporting.GetTotalDistanceKm: Integer;
begin
  Result := TRUNC( TotalDistance/1000 ) + 1;
end;

function TReporting.GetTotalDuration: Integer;
var
  LItem: TReportStep;

begin
  Result := 0;
  for LItem in Steps do
  begin
    Result := Result + LItem.Duration;
  end;
end;

{ TReportStep }

function TReportStep.GetDistanceKm: Double;
begin
  Result := Distance / 1000;
end;

function TReportStep.GetDurationMin: Double;
begin
  Result := Duration / 60;
end;

end.
