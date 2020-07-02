unit Modules.Resources;

interface

uses
  System.SysUtils, System.Classes, Vcl.BaseImageCollection, AdvTypes, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, AdvStyleIF, AdvAppStyler;

type
  TResources = class(TDataModule)
    Collection: TAdvSVGImageCollection;
    Images: TVirtualImageList;
    AppStyler: TAdvAppStyler;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Resources: TResources;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
