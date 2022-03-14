program Totvs;

uses
  Vcl.Forms,
  Totvs.view.principal in 'view\Totvs.view.principal.pas' {ViewPrincipal},
  Totvs.Controller.ViewPrincipal in 'controller\Totvs.Controller.ViewPrincipal.pas',
  Totvs.Interfaces.IBotao in 'interface\Totvs.Interfaces.IBotao.pas',
  Totvs.Model.Botao in 'model\Totvs.Model.Botao.pas',
  Totvs.Interfaces.IObservable in 'interface\Totvs.Interfaces.IObservable.pas',
  Totvs.Interfaces.IPanel in 'interface\Totvs.Interfaces.IPanel.pas',
  Totvs.Service.Memoria in 'service\Totvs.Service.Memoria.pas',
  Totvs.Model.HistoricoOperacao in 'model\Totvs.Model.HistoricoOperacao.pas',
  Totvs.view.FrameObserver in 'view\Totvs.view.FrameObserver.pas' {FrameObserver: TFrame},
  Totvs.view.Botoes in 'view\Totvs.view.Botoes.pas' {ViewBotoes: TFrame},
  Totvs.view.Calculos in 'view\Totvs.view.Calculos.pas' {ViewCalculos: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
