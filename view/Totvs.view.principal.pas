unit Totvs.view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Totvs.Controller.ViewPrincipal, System.Classes, Vcl.StdCtrls,
  Totvs.Service.Memoria;

type
  TViewPrincipal = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FController: TControllerViewPrincipal;
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  FController := TControllerViewPrincipal.Create(Self);
end;

end.
