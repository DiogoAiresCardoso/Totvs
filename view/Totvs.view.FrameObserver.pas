unit Totvs.view.FrameObserver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Totvs.Interfaces.IObservable,
  Generics.Collections;

type
  TFrameObserver = class(TFrame, iObserver, iSubject)
  private
    { Private declarations }

  protected
    FListObserver: TList<iObserver>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); reintroduce; overload;
    destructor Destroy; override;
    // funcoes observer
    procedure ProcessarNotificacao(aValue: String); virtual; abstract;
    // funcoes subject
    function AddObserver(poObserver: iObserver): iSubject;
    function RemoverObserver(poObserver: iObserver): iSubject;
    procedure Notificar(aValue: String);
  end;

implementation

{$R *.dfm}

{ TFrameObserver }

function TFrameObserver.AddObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Add(poObserver);
end;

constructor TFrameObserver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Parent := TWinControl(AOwner);
  FListObserver := TList<iObserver>.Create;
end;

destructor TFrameObserver.Destroy;
begin
  FListObserver.Clear;
  FreeAndNil(FListObserver);
  inherited Destroy;
end;

procedure TFrameObserver.Notificar(aValue: String);
var
  I: Integer;
begin
  for I := 0 to Pred(FListObserver.Count) do
    FListObserver.Items[I].ProcessarNotificacao(aValue);
end;

function TFrameObserver.RemoverObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Delete(FListObserver.IndexOf(poObserver));
end;

end.
