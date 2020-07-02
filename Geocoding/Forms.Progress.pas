unit Forms.Progress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvGlowButton, Vcl.ComCtrls;

type
  TFrmProgress = class(TForm)
    Progress: TProgressBar;
    btnCancel: TAdvGlowButton;
    lblInfo: TLabel;
  private
    { Private declarations }
    procedure UpdateLabel;
  public
    { Public declarations }
    procedure Start( ACaption:String; AMax: Integer );
    procedure UpdateProgress( AValue: Integer );

  end;

var
  FrmProgress: TFrmProgress;

implementation

{$R *.dfm}

{ TForm1 }

procedure TFrmProgress.Start(ACaption:String; AMax: Integer);
begin
  Progress.Max := AMax;
  Progress.Position := 0;

  Caption := ACaption;

  UpdateLabel;

  self.Show;
end;

procedure TFrmProgress.UpdateLabel;
begin
  lblInfo.Caption := Format( '%d/%d', [Progress.Position, Progress.Max] );
end;

procedure TFrmProgress.UpdateProgress(AValue: Integer);
begin
  Progress.Position := Progress.Max - (AValue + 1);
  UpdateLabel;
  Application.ProcessMessages;
end;

end.
