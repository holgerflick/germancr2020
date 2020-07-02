unit Forms.About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Modules.Resources,
  AdvGlowButton, AdvStyleIF, AdvAppStyler;

type
  TFrmAbout = class(TForm)
    Image1: TImage;
    AdvGlowButton1: TAdvGlowButton;
    AdvFormStyler1: TAdvFormStyler;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

end.
