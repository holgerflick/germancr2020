unit Forms.SelectState;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvCombo, AdvGlowButton, Modules.Resources,
  AdvStyleIF, AdvAppStyler, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmSelectState = class(TForm)
    cbStates: TAdvComboBox;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    FormStyler: TAdvFormStyler;
  private
    { Private declarations }
    procedure InitCombo;
  public
    { Public declarations }
    function SelectState( ADefault : String ):String;
  end;

var
  FrmSelectState: TFrmSelectState;

implementation

{$R *.dfm}

uses Modules.Data;

{ TFrmSelectState }

procedure TFrmSelectState.InitCombo;
var
  LQuery: TFDQuery;

begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := DBController.Connection;
    LQuery.SQL.Text := 'select distinct state from coordinates order by state';
    LQuery.Open;

    cbStates.Items.Clear;
    cbStates.Items.BeginUpdate;
    while not LQuery.Eof do
    begin
      cbStates.Items.Add( LQuery['state'] );
      LQuery.Next;
    end;
  finally
    cbStates.Items.EndUpdate;
    LQuery.Free;
  end;
end;

function TFrmSelectState.SelectState(ADefault: String): String;
begin
  InitCombo;

  cbStates.ItemIndex := cbStates.Items.IndexOf(ADefault);

  if self.ShowModal = mrOK then
  begin
    Result := self.cbStates.Text;
  end
  else
  begin
    Result := '';
  end;
end;

end.
