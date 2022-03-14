unit Totvs.Interfaces.IPanel;

interface

uses Vcl.ExtCtrls;

type

  iPanel = interface
    ['{5B106FA9-6BD7-44D0-8969-916FF2945DEA}']
    procedure CriarPanel;
    procedure DestruirPanel;
    function GetPanel: TCustomPanel;
  end;

  iPanelTexto = interface
    ['{5FB7221F-1094-4902-886C-0FDB9115F98B}']
    procedure SetarTexto(aValue: String);
  end;

implementation

end.
