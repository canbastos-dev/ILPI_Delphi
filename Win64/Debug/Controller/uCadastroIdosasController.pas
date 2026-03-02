unit uCadastroIdosasController;

interface

uses
  uFrmCadastroIdosas, uDataModule, System.SysUtils, Vcl.Controls;

type
  TCadastroIdosasController = class
  public
    class procedure AbrirCadastroClientes(AOwner: TWinControl);
  end;

implementation

class procedure TCadastroIdosasController.AbrirCadastroClientes(AOwner: TWinControl);
var
  Frm: TFormCadastroIdosas;
begin
  // Garante conexão
  if not uDados.con_ILPI.Connected then
     uDados.Conectar;

  // Configura Query
  uDados.fdqDados.Close;
  uDados.fdqDados.Open();

  // Cria formulário
  Frm := TFormCadastroIdosas.Create(AOwner);
  Frm.SetDataSet(uDados.fdqDados);

  Frm.Parent := AOwner;        // Define o container
  Frm.Visible := True;         // Mostra
end;

end.
