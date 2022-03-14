unit Totvs.Model.HistoricoOperacao;

interface

type

  THistoricoOperacao = class
  private
    FOperacao: String;
    FPrimeiroValor: Double;
    FSegundoValor: Double;
    FResultado: Double;
    FJaCalculado: Boolean;
    FTextoInEdit: String;
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property PrimeiroValor: Double read FPrimeiroValor write FPrimeiroValor;
    property SegundoValor: Double read FSegundoValor write FSegundoValor;
    property Operacao: String read FOperacao write FOperacao;
    property Resultado: Double read FResultado write FResultado;
    property JaCalculado: Boolean read FJaCalculado write FJaCalculado default False;
    property TextoInEdit: String read FTextoInEdit write FTextoInEdit;
  end;

implementation


end.
