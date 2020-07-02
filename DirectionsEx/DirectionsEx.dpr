program DirectionsEx;

{$R *.dres}

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {FrmMain},
  Modules.Reporting in 'Modules.Reporting.pas' {Reporting: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TReporting, Reporting);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
