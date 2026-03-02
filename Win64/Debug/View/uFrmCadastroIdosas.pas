unit uFrmCadastroIdosas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBaseCadastro, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TFormCadastroIdosas = class(TFrmBaseCadastro)
    lbNome: TLabel;
    lbCPF: TLabel;
    lbRG: TLabel;
    lbDataNascimento: TLabel;
    lbSexo: TLabel;
    dbeNome: TDBEdit;
    dbeApelidp: TDBEdit;
    lbApelido: TLabel;
    dbeRG: TDBEdit;
    mkeDataNasc: TMaskEdit;
    mkeCPF: TMaskEdit;
    lbEstadoCivil: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    // Declaração de um método que ira receber um obeto TDATASET (classe-mãe astrata
    // que aceita todos os qualquer componente de acesso a dados no Delphi) POLIMORFISMO
    procedure SetDataSet(ADataSet: TDataSet);
  end;

var
  FormCadastroIdosas: TFormCadastroIdosas;

implementation

{$R *.dfm}

procedure TFormCadastroIdosas.SetDataSet(ADataSet: TDataSet);
begin
  dsDados.DataSet := ADataSet;
end;

end.
