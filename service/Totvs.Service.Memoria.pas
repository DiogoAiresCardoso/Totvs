unit Totvs.Service.Memoria;

interface

uses Generics.Collections, Totvs.Model.HistoricoOperacao, SysUtils, Totvs.Interfaces.IObservable;

type
  TMemoriaCalculadora = class(TInterfacedObject, iSubject, iObserver)
  strict private
    class var FMemoriaCalculadora: TMemoriaCalculadora;
  private
    { private declarations }
  protected
    { protected declarations }
    FListObserver: TList<iObserver>;
    FHistorico: TList<THistoricoOperacao>;
    FIndexAtual: Integer;
    FUltimoDigitado: String;
    constructor Create;
  public
    { public declarations }
    class function GetInstance: TMemoriaCalculadora;
    class procedure ReleaseInstance;
    destructor Destroy; override;

    // funcao observer
    procedure ProcessarNotificacao(aValue: String);
    // funcao subject
    function AddObserver(poObserver: iObserver): iSubject;
    function RemoverObserver(poObserver: iObserver): iSubject;
    procedure Notificar(aValue: String);


    procedure LimparOperacao;
    procedure AdicionarValor(psValor: String);
    procedure AdicionarOperacao(psOperacao: String);
    procedure RealizarCalculo;
    function PegarValorCalculado: String;
  end;

implementation

{ TMemoriaCalculadora }

uses StrUtils;

procedure TMemoriaCalculadora.AdicionarOperacao(psOperacao: String);
begin
  FHistorico.Items[FIndexAtual].Operacao := psOperacao;
end;

procedure TMemoriaCalculadora.AdicionarValor(psValor: String);
var
  oHistorico: THistoricoOperacao;
begin
  if (FHistorico.Items[FIndexAtual].JaCalculado) then
  begin
    oHistorico := THistoricoOperacao.Create;
    FHistorico.Add(oHistorico);

    psValor := FloatToStr(FHistorico.Items[FIndexAtual].Resultado);

    if (FHistorico.Count > 1) or (FHistorico.Items[FIndexAtual].JaCalculado) then
      Inc(FIndexAtual);
  end;

  if FHistorico.Items[FIndexAtual].Operacao = '' then
    FHistorico.Items[FIndexAtual].PrimeiroValor := StrToFloat(psValor)
  else
    FHistorico.Items[FIndexAtual].SegundoValor := StrToFloat(psValor);
end;

function TMemoriaCalculadora.AddObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Add(poObserver);
end;

constructor TMemoriaCalculadora.Create;
var
  oHistorico: THistoricoOperacao;
begin
  FListObserver := TList<iObserver>.Create;
  FHistorico := TList<THistoricoOperacao>.Create;
  FIndexAtual := 0;

  oHistorico := THistoricoOperacao.Create;
  FHistorico.Add(oHistorico);
end;

destructor TMemoriaCalculadora.Destroy;
begin
  FListObserver.Clear;
  FHistorico.Clear;
  FreeAndNil(FHistorico);
  FreeAndNil(FListObserver);
  inherited;
end;

class function TMemoriaCalculadora.GetInstance: TMemoriaCalculadora;
begin
  if not Assigned(Self.FMemoriaCalculadora) then
    Self.FMemoriaCalculadora := TMemoriaCalculadora.Create;

  Result := Self.FMemoriaCalculadora;
end;

procedure TMemoriaCalculadora.Notificar(aValue: String);
var
  I: Integer;
begin
  for I := 0 to Pred(FListObserver.Count) do
    FListObserver.Items[I].ProcessarNotificacao(aValue);
end;

procedure TMemoriaCalculadora.LimparOperacao;
begin
  while FHistorico.Count > 0 do
    FHistorico.Delete(Pred(FHistorico.Count));

  FIndexAtual := 0;
end;

function TMemoriaCalculadora.PegarValorCalculado: String;
begin
  if FIndexAtual > 0 then
    Result := FloatToStr(FHistorico.Items[Pred(FIndexAtual)].Resultado)
  else
    Result := FloatToStr(FHistorico.Items[FIndexAtual].Resultado);
end;

procedure TMemoriaCalculadora.RealizarCalculo;
begin
  case AnsiIndexStr(FHistorico.Items[FIndexAtual].Operacao, ['+', '-', '/', 'X', '*']) of
    0: FHistorico.Items[FIndexAtual].Resultado := FHistorico.Items[FIndexAtual].PrimeiroValor + FHistorico.Items[FIndexAtual].SegundoValor;
    1: FHistorico.Items[FIndexAtual].Resultado := FHistorico.Items[FIndexAtual].PrimeiroValor - FHistorico.Items[FIndexAtual].SegundoValor;
    2: FHistorico.Items[FIndexAtual].Resultado := FHistorico.Items[FIndexAtual].PrimeiroValor / FHistorico.Items[FIndexAtual].SegundoValor;
    3,4: FHistorico.Items[FIndexAtual].Resultado := FHistorico.Items[FIndexAtual].PrimeiroValor * FHistorico.Items[FIndexAtual].SegundoValor;
  end;
  FHistorico.Items[FIndexAtual].JaCalculado := True;

  FUltimoDigitado := FloatToStr(FHistorico.Items[FIndexAtual].Resultado);
  Notificar(FUltimoDigitado);
  FUltimoDigitado := '';
end;

class procedure TMemoriaCalculadora.ReleaseInstance;
begin
  if Assigned(Self.FMemoriaCalculadora) then
    Self.FMemoriaCalculadora.Free;
end;

function TMemoriaCalculadora.RemoverObserver(poObserver: iObserver): iSubject;
begin
  FListObserver.Delete(FListObserver.IndexOf(poObserver));
end;

procedure TMemoriaCalculadora.ProcessarNotificacao(aValue: String);
begin
  if aValue = '<X' then
    aValue := #8
  else if (aValue = 'CE') or (aValue = 'C') then
  begin
    LimparOperacao;
    Notificar(aValue);
    Exit;
  end;

  FUltimoDigitado := aValue;
  Notificar(aValue);

  case AnsiIndexStr(aValue, ['+', '-', 'X', '/', '*', '=', #8]) of
    0..4:
    begin
      AdicionarValor(FHistorico.Items[FIndexAtual].TextoInEdit);
      AdicionarOperacao(aValue);
      FHistorico.Items[FIndexAtual].TextoInEdit := '';
    end;
    5:
    begin
      AdicionarValor(FHistorico.Items[FIndexAtual].TextoInEdit);
      RealizarCalculo;
      FHistorico.Items[FIndexAtual].TextoInEdit := '';
    end;
    6:
    begin
      if Length(FHistorico.Items[FIndexAtual].TextoInEdit) = 1 then
        FHistorico.Items[FIndexAtual].TextoInEdit := ''
      else
        FHistorico.Items[FIndexAtual].TextoInEdit := Copy(FHistorico.Items[FIndexAtual].TextoInEdit,
                                                          0, Length(FHistorico.Items[FIndexAtual].TextoInEdit) -1);
    end
  else
    FHistorico.Items[FIndexAtual].TextoInEdit := FHistorico.Items[FIndexAtual].TextoInEdit + aValue;
  end;
end;

end.
