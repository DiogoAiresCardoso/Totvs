unit Totvs.view.Botoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Totvs.view.FrameObserver, Vcl.ExtCtrls, Totvs.Interfaces.IObservable,
  Generics.Collections, Totvs.Interfaces.IBotao, Vcl.Buttons, Totvs.Model.Botao;

type
  TViewBotoes = class(TFrameObserver)
  private
    { Private declarations }
    FListBotoes: TList<iBotao>;
    FGridPanel: TGridPanel;
    procedure AjustarPanel;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; poObserver: iObserver);
    destructor Destroy; override;
    procedure AdicionarBotoes(nBotao: integer = -1);

    procedure ProcessarNotificacao(aValue: String); override;
  end;

var
  ViewBotoes: TViewBotoes;

implementation

{$R *.dfm}


{ TViewBotoes }

procedure TViewBotoes.AdicionarBotoes(nBotao: integer);
var
  oBotao: TModelBotao;
  i: integer;
begin
  if nBotao = -1 then
  begin
    i := 0;
    while i <= 19 do
    begin
      AdicionarBotoes(i);
      Inc(i);
    end;
    Exit;
  end;

  oBotao := TModelBotao.Create(FGridPanel);
  for I := 0 to Pred(FListObserver.Count) do
    oBotao.AddObserver(FListObserver.Items[I]);

  case nBotao of
    0: oBotao.SetCaption('%');
    1: oBotao.SetCaption('CE');
    2: oBotao.SetCaption('C');
    3: oBotao.SetCaption('<X');
    4: oBotao.SetCaption('7');
    5: oBotao.SetCaption('8');
    6: oBotao.SetCaption('9');
    7: oBotao.SetCaption('X');
    8: oBotao.SetCaption('4');
    9: oBotao.SetCaption('5');
    10: oBotao.SetCaption('6');
    11: oBotao.SetCaption('-');
    12: oBotao.SetCaption('1');
    13: oBotao.SetCaption('2');
    14: oBotao.SetCaption('3');
    15: oBotao.SetCaption('+');
    16: oBotao.SetCaption('/');
    17: oBotao.SetCaption('0');
    18: oBotao.SetCaption(',');
    19: oBotao.SetCaption('=');
  end;

  FListBotoes.Add(oBotao);
end;

procedure TViewBotoes.AjustarPanel;
var
  I: Integer;
begin
  FGridPanel.Align := alClient;
  FGridPanel.AlignWithMargins := True;
  // definindo a quantidade de colunas
  for I := FGridPanel.ColumnCollection.Count to 3 do
    FGridPanel.ColumnCollection.Add;
  // definindo a quantidade de linhas
  for I := FGridPanel.RowCollection.Count to 4 do
    FGridPanel.RowCollection.Add;
end;

constructor TViewBotoes.Create(AOwner: TComponent; poObserver: iObserver);
begin
  inherited Create(AOwner);
  AddObserver(poObserver);
  // criando o componente
  FGridPanel := TGridPanel.Create(AOwner);
  // setando propriedades principais
  FGridPanel.Parent := TWinControl(AOwner);

  FListBotoes := TList<iBotao>.Create;

  AjustarPanel;
  Self.Visible := True;
  Self.Align := alClient;

  AdicionarBotoes;
end;

destructor TViewBotoes.Destroy;
begin
  FreeAndNil(FListBotoes);
  inherited Destroy;
end;

procedure TViewBotoes.ProcessarNotificacao(aValue: String);
begin
  raise Exception.Create('Não implementado');
end;

end.
