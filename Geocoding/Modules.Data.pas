unit Modules.Data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDBController = class(TDataModule)
    Connection: TFDConnection;
    QuCoordinates: TFDQuery;
    QuCounties: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DBController: TDBController;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDBController.DataModuleCreate(Sender: TObject);
begin
  QuCounties.Open;
  QuCoordinates.Open;
end;

procedure TDBController.DataModuleDestroy(Sender: TObject);
begin
  QuCounties.Close;
  QuCoordinates.Close;

  Connection.Close;
end;

end.
