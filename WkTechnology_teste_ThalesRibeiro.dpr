program WkTechnology_teste_ThalesRibeiro;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uDM in 'uDM.pas' {frmDM: TDataModule},
  uPedidos in 'bin\uPedidos.pas' {frmPedidos},
  uClientes in 'bin\uClientes.pas',
  uProdutos in 'bin\uProdutos.pas',
  uobjPedidos in 'bin\uobjPedidos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDM, frmDM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
