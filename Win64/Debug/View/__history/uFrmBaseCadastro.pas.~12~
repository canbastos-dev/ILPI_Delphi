unit uFrmBaseCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmBaseCadastro = class(TForm)
    pnlPrincipal: TPanel;
    pgPrincipal: TPageControl;
    tsListagem: TTabSheet;
    tsCadastro: TTabSheet;
    dbgDados: TDBGrid;
    edtPesquisar: TEdit;
    btnPesquisar: TButton;
    dsDados: TDataSource;
    Label1: TLabel;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnSalvar: TButton;

    procedure FormCreate(Sender: TObject); virtual;
    procedure btnNovoClick(Sender: TObject); virtual;
    procedure btnEditarClick(Sender: TObject); virtual;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
//    procedure edtPesquisarChange(Sender: TObject); virtual;

  protected
    procedure Salvar; virtual; abstract;
    procedure Excluir; virtual; abstract;
    procedure LimparCampos; virtual; abstract;
    procedure ValidarCampos; virtual;
    procedure ModoInsercao; virtual;
    procedure ModoEdicao; virtual;
    procedure ModoNavegacao; virtual;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBaseCadastro: TFrmBaseCadastro;

implementation

{$R *.dfm}

procedure TFrmBaseCadastro.btnNovoClick(Sender: TObject);
begin
  LimparCampos;
  ModoInsercao;
  pgPrincipal.ActivePage := tsCadastro; // já vai para a aba de cadastro
end;

procedure TFrmBaseCadastro.btnEditarClick(Sender: TObject);
begin
  ModoEdicao;
  pgPrincipal.ActivePage := tsCadastro;
end;

procedure TFrmBaseCadastro.btnSalvarClick(Sender: TObject);
begin
  try
    ValidarCampos;
    Salvar;
    ModoNavegacao;
    pgPrincipal.ActivePage := tsListagem; // volta para a lista após salvar
    ShowMessage('Registro salvo com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;

procedure TFrmBaseCadastro.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Confirma exclusão?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Excluir;
    ModoNavegacao;
  end;
end;

procedure TFrmBaseCadastro.btnCancelarClick(Sender: TObject);
begin
  LimparCampos;
  ModoNavegacao;
  pgPrincipal.ActivePage := tsListagem;
end;

procedure TFrmBaseCadastro.ModoInsercao;
begin
  btnNovo.Enabled    := False;
  btnEditar.Enabled  := False;
  btnSalvar.Enabled  := True;
  btnExcluir.Enabled := False;
  btnCancelar.Enabled := True;
end;

procedure TFrmBaseCadastro.ModoEdicao;
begin
  btnNovo.Enabled    := False;
  btnEditar.Enabled  := False;
  btnSalvar.Enabled  := True;
  btnExcluir.Enabled := True;
  btnCancelar.Enabled := True;
end;

procedure TFrmBaseCadastro.ModoNavegacao;
begin
  btnNovo.Enabled    := True;
  btnEditar.Enabled  := True;
  btnSalvar.Enabled  := False;
  btnExcluir.Enabled := False;
  btnCancelar.Enabled := False;
end;

procedure TFrmBaseCadastro.ValidarCampos;
begin
  // base vazia — filhos sobrescrevem
end;

procedure TFrmBaseCadastro.FormCreate(Sender: TObject);
begin
  ModoNavegacao; // sempre começa no modo correto
  pgPrincipal.ActivePage := tsListagem;
end;

end.
