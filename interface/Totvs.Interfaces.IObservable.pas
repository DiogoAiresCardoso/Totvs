unit Totvs.Interfaces.IObservable;

interface

type

  iObserver = interface
    ['{51EDC3AB-AE58-4A0D-AF45-4CA25AC4EC70}']
    procedure ProcessarNotificacao(aValue: String);
  end;

  iSubject = interface
    ['{D872AB92-9F24-47CA-ACFB-52F492F91A13}']
    function AddObserver(poObserver: iObserver): iSubject;
    function RemoverObserver(poObserver: iObserver): iSubject;
    procedure Notificar(aValue: String);
  end;

implementation

end.
