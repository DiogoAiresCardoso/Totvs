unit Totvs.Interfaces.IBotao;

interface

uses Vcl.Buttons;

type

  iBotao = interface
    ['{657C2DC8-EA9E-4805-869C-869BE1D107E0}']
    function SetCaption(sCaption: String): iBotao;
    procedure onClick(Sender: TObject);
  end;

implementation

end.
