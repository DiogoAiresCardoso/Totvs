unit Totvs.Model.Botao;

interface

uses Totvs.Interfaces.IBotao, Vcl.Buttons, System.SysUtils, Vcl.ExtCtrls, Totvs.Interfaces.IObservable,
  System.Generics.Collections, Vcl.Controls;

type
  TModelBotao = class(TInterfacedObject, iBotao, iSubject)
  private
    { private declarations }
    FBotao: TSpeedButton;
    FListObserver: TList<iObserver>;
    FCaption: String;
  protected
    { protected declarations }
    // funcoes do iBotao
    procedure onClick(Sender: TObject);
  public
    { public declarations }
    constructor Create(AOwner: TCustomPanel);
    destructor Destroy; override;
    // funcoes do iBotao
    function SetCaption(sCaption: String): iBotao;
    function GetButton: TSpeedButton;
    // funcoes do observable
    function AddObserver(poObserver: iObserver): iSubject;
    function RemoverObserver(poObserver: iObserver): iSubject;
    procedure Notificar(aValue: String);
  end;

implementation

{ TModelBotao }

function TModelBotao.AddObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Add(poObserver)
end;

constructor TModelBotao.Create(AOwner: TCustomPanel);
begin
  FBotao := TSpeedButton.Create(AOwner);
  FBotao.Parent := AOwner;
  FBotao.OnClick := onClick;
  FBotao.Align := alClient;
  FBotao.AlignWithMargins := True;

  FListObserver := TList<iObserver>.Create;
end;

destructor TModelBotao.Destroy;
begin
  FBotao := nil;
  FreeAndNil(FListObserver);
  inherited Destroy;
end;

function TModelBotao.GetButton: TSpeedButton;
begin
  result := FBotao;
end;

procedure TModelBotao.Notificar(aValue: String);
var
  I: Integer;
begin
  for I := 0 to Pred(FListObserver.Count) do
    FListObserver.Items[I].ProcessarNotificacao(aValue);
end;

procedure TModelBotao.onClick(Sender: TObject);
begin
  if (TSpeedButton(Sender).Caption = '%') then
    raise Exception.Create('Não implementado');

  Notificar(TSpeedButton(Sender).Caption);
end;

function TModelBotao.RemoverObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Delete(FListObserver.IndexOf(poObserver));
end;

function TModelBotao.SetCaption(sCaption: String): iBotao;
begin
  Result := Self;
  FCaption := sCaption;
  FBotao.Caption := sCaption;
end;

end.
