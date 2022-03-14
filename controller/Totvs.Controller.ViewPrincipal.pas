unit Totvs.Controller.ViewPrincipal;

interface

uses
  Vcl.Forms, Vcl.Controls, Vcl.Buttons, Totvs.Interfaces.IBotao, Generics.Collections,
  System.SysUtils, Vcl.ExtCtrls, Totvs.Interfaces.IPanel, Totvs.Interfaces.IObservable,
  Totvs.Service.Memoria, Totvs.view.Calculos, Totvs.view.Botoes;

type
  TControllerViewPrincipal = class
  private
    { private declarations }
  protected
    { protected declarations }
    FOwner: TForm;
    FViewCalculos: TViewCalculos;
    FViewBotoes: TViewBotoes;
    FMemoriaCalculadora: TMemoriaCalculadora;
    FValor: String;
  public
    { public declarations }
    constructor Create(aOwner: TForm);
    destructor Destroy; override;
  end;

implementation

{ TControllerViewPrincipal }

uses StrUtils;

constructor TControllerViewPrincipal.Create(aOwner: TForm);
begin
  FOwner := aOwner;

  FMemoriaCalculadora := TMemoriaCalculadora.GetInstance;

  FViewCalculos := TViewCalculos.Create(FOwner, FMemoriaCalculadora);
  FViewBotoes := TViewBotoes.Create(FOwner, FMemoriaCalculadora);

  FMemoriaCalculadora.AddObserver(FViewCalculos);
end;

destructor TControllerViewPrincipal.Destroy;
begin
  FOwner := nil;
  FViewCalculos.Free;
  FViewBotoes.Free;
  FMemoriaCalculadora.ReleaseInstance;
  inherited Destroy;
end;

end.
