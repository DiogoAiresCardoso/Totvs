unit Totvs.view.Calculos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Totvs.view.FrameObserver, Vcl.StdCtrls, Totvs.Interfaces.IObservable;

type
  TViewCalculos = class(TFrameObserver)
    edtCalculoDetalhe: TEdit;
    edtTexto: TEdit;
    procedure edtTextoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; poObserver: iObserver);
    procedure ProcessarNotificacao(aValue: String); override;
  end;

var
  ViewCalculos: TViewCalculos;

implementation

uses StrUtils;

{$R *.dfm}

{ TViewCalculos }

constructor TViewCalculos.Create(AOwner: TComponent; poObserver: iObserver);
begin
  inherited Create(AOwner);
  Self.Parent := TWinControl(AOwner);
  Self.Visible := True;
  Self.Align := alTop;

  AddObserver(poObserver);
end;

procedure TViewCalculos.edtTextoKeyPress(Sender: TObject; var Key: Char);
var
  FUltimoChar: String;
begin
  if Key = #13 then
    FUltimoChar := '='
  else
    FUltimoChar := Key;

  Key := #0;

  Notificar(FUltimoChar);
end;

procedure TViewCalculos.ProcessarNotificacao(aValue: String);
begin
  case AnsiIndexStr(aValue, ['+', '-', 'X', '/', '*', '=', #8]) of
    0..5:
    begin
      edtCalculoDetalhe.Text := edtCalculoDetalhe.Text + edtTexto.Text + aValue;
      edtTexto.Text := '';
    end;
    6:
    begin
      if Length(edtTexto.Text) = 1 then
        edtTexto.Text := ''
      else
        edtTexto.Text := Copy(edtTexto.Text, 0, Length(edtTexto.Text) -1);
    end
  else
    edtTexto.Text := edtTexto.Text + aValue;
  end;
end;


end.
