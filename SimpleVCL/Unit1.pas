unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Map: TTMSFNCMaps;
    btnGoogle: TButton;
    btnLayers: TButton;
    procedure btnGoogleClick(Sender: TObject);
    procedure btnLayersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGoogleClick(Sender: TObject);
begin
  Map.Service := msGoogleMaps;
end;

procedure TForm1.btnLayersClick(Sender: TObject);
begin
  Map.Service := msOpenLayers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // TODO: assign keys
end;

end.
