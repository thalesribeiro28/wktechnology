unit uPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClientes, uProdutos,
  Vcl.DBCtrls, uobjPedidos;

type
  TModo = (novoPedido, altNovoPedido, carregaPedido, CancelaPedido);

  TModos = set of TModo;

type
  TfrmPedidos = class(TForm)
    pnlTop: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Shape3: TShape;
    lblInfo: TLabel;
    lblCancelar: TLabel;
    Shape4: TShape;
    Shape5: TShape;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    Label6: TLabel;
    edtCdCliente: TEdit;
    Label7: TLabel;
    edtNM_Cliente: TEdit;
    edtCdProduto: TEdit;
    Label8: TLabel;
    edtNM_Produto: TEdit;
    Label9: TLabel;
    edtNO_Quantidade: TEdit;
    Shape7: TShape;
    lblInserir: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Image6: TImage;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    Label15: TLabel;
    edtVL_Unitario: TEdit;
    Label16: TLabel;
    edtVL_Total: TEdit;
    cdsItens: TClientDataSet;
    cdsItensID_Produto: TIntegerField;
    cdsItensNM_Produto: TStringField;
    cdsItensNO_Quantidade: TIntegerField;
    cdsItensVL_Unidade: TFloatField;
    cdsItensVL_Total: TFloatField;
    dsoItens: TDataSource;
    Shape10: TShape;
    Shape11: TShape;
    Label17: TLabel;
    lblCancela: TLabel;
    Image7: TImage;
    Label19: TLabel;
    Shape12: TShape;
    Shape13: TShape;
    lblCarregarPedido: TLabel;
    shpCarregarPedido: TShape;
    lblCancelarPedido: TLabel;
    shpCancelarPedido: TShape;
    lblVlTotal: TLabel;
    cdsItensTotal: TAggregateField;
    DBText1: TDBText;
    edtpedido: TEdit;
    lblNOPedido: TLabel;
    lblInfo2: TLabel;
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseEnter(Sender: TObject);
    procedure Shape1MouseLeave(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtCdClienteExit(Sender: TObject);
    procedure edtCdClienteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCdProdutoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtVL_UnitarioExit(Sender: TObject);
    procedure edtNO_QuantidadeExit(Sender: TObject);
    procedure Shape7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape7MouseEnter(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure shpCarregarPedidoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpCancelarPedidoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCarregarPedidoClick(Sender: TObject);
    procedure lblCancelarPedidoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lblInserirClick(Sender: TObject);
    procedure edtVL_UnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtpedidoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure Label17Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure lblCancelaClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }

    vCliente   : Clientes;
    auxCliente : TCliente;

    vProdutos  : Produtos;
    auxProdutos: TProduto;

    vobjPedido : TobjPedido;
    auxPedido  : TPedidos;

    FID_Cliente : Integer;
    FID_Pedido  : Integer;
    FModo       : TModos;
    FModo_Old   : TModos;
    FInfo       : string;
    function MyStrToFloat(s : string) : real;
    procedure CalcVLTotal;
    procedure ClearProduto;
    procedure setID_Cliente(ID_Cliente:Integer);
    procedure setTPModo(ATipoModo : TModos);
    procedure setID_Pedido(ID_Pedido:Integer);
    procedure ItemAdd;
    procedure CarregarPedido(AID_Pedido : Integer);
    procedure CancelarPedido(AID_Pedido : Integer);
    procedure setInfo(AInfo : string);
    procedure OnClickInserir;
    procedure OnClickConfirmar;
    procedure OnClickNovoPedido;
    procedure OnClickCarregarPedido;
    property ID_Cliente : Integer read FID_Cliente write setID_Cliente;
    property Modo : TModos read FModo write setTPModo;
    property ID_Pedido : Integer read FID_Pedido write setID_Pedido;
    property Info : String read FInfo write setInfo;
  public
    { Public declarations }
  end;


var
  frmPedidos: TfrmPedidos;

implementation


{$R *.dfm}

uses uDM;

procedure TfrmPedidos.CalcVLTotal;
var
  vl_total : real;
  vl_unitario : real;
begin
  if edtVL_Unitario.Text <> '' then
  begin
    vl_unitario := MyStrToFloat(edtVL_Unitario.Text);

    if ((edtNO_Quantidade.Text <> '')) then
    begin
      if edtVL_Unitario.Text <> '' then
      begin
        vl_total := StrToInt(edtNO_Quantidade.Text) * vl_unitario;
        edtVL_Total.Text := FloatToStrF(vl_total, ffNumber, 18,2);
      end;
    end;
  end;
end;

procedure TfrmPedidos.CancelarPedido(AID_Pedido: Integer);
begin

   case Application.MessageBox('Confirma exclusão do pedido selecionado?','Excluir Pedido?', MB_YESNO + MB_ICONQUESTION) of
        IDYES:
          begin
            if vobjPedido.PedidoDel(AID_Pedido).sucess then
            begin
              ShowMessage('Pedido Excluído com sucesso!');
            end
            else
            begin
              info := 'erro ao excluir pedido';
            end;
          end;
      end;

end;

procedure TfrmPedidos.CarregarPedido(AID_Pedido: Integer);
begin
  info := '';
  auxPedido  := vobjPedido.GetPedido(AID_Pedido);

  if auxPedido.retorno.sucess then
  begin
    auxCliente := vCliente.GetCliente(auxPedido.ID_Cliente);

    if (auxCliente.retorno.sucess) then
    begin
      ID_Cliente         := auxCliente.ID_Cliente;
      edtNM_Cliente.Text := auxCliente.NM_Cliente;
      edtCdCliente.Text  := IntToStr(ID_Cliente);

      auxCliente.ID_Cliente := 0;
      auxCliente.NM_Cliente := '';

      ID_Pedido  := auxPedido.ID_Pedido;
    end;
  end
  else
  begin
    Application.MessageBox(PChar('Pedido não localizado'), 'Erro ao selecionar pedido', MB_OK + MB_ICONWARNING);
    edtpedido.SelectAll;
    edtPedido.SetFocus;
  end;

end;

procedure TfrmPedidos.ClearProduto;
begin
  edtNM_Produto.Clear;
  edtVL_Unitario.Clear;
  edtVL_Total.Clear;
  edtNO_Quantidade.Clear;
  edtCdProduto.SetFocus;
  edtCdProduto.SelectAll;
  auxProdutos.ID_Produto := 0;
  auxProdutos.NM_Produto := '';
  edtCdProduto.Text      := '';
end;

procedure TfrmPedidos.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if altNovoPedido in FModo then
  begin
    Info := 'Ação não permitida enquanto está alterando um lançamento.';
    Exit;
  end;

  Info := '';

  if (KEY = VK_DELETE) then
  begin
    if cdsItens.FieldByName('ID_Produto').AsInteger > 0 then
    begin
      case Application.MessageBox('Confirma exclusão do produto selecionado?','Excluir Produto?', MB_YESNO + MB_ICONQUESTION) of
        IDYES:
          begin
            cdsItens.Delete;
          end;
      end;
    end;
  end
  else if (KEY = VK_RETURN) then
  begin

    if cdsItens.FieldByName('ID_Produto').AsInteger > 0 then
    begin
      auxProdutos.ID_Produto     := cdsItens.FieldByName('ID_Produto').AsInteger;
      auxProdutos.NM_Produto     := cdsItens.FieldByName('NM_Produto').AsString;
      auxProdutos.VL_Produto     := cdsItens.FieldByName('VL_Unidade').AsFloat;
      auxProdutos.NO_Quantidade  := cdsItens.FieldByName('NO_Quantidade').ASInteger;
      auxProdutos.VL_Unidade     := cdsItens.FieldByName('VL_Unidade').AsFloat;
      auxProdutos.VL_Total       := cdsItens.FieldByName('VL_Total').AsFloat;

      edtCdProduto.Text          := cdsItens.FieldByName('ID_Produto').AsString;
      edtNM_Produto.Text         := cdsItens.FieldByName('NM_Produto').AsString;
      edtNO_Quantidade.Text      := cdsItens.FieldByName('NO_Quantidade').AsString;
      edtVL_Unitario.Text        := FloatToStrF(cdsItens.FieldByName('VL_Unidade').AsFloat,ffNumber,18,2);
      CalcVLTotal;
      cdsItens.Delete;

      setTPModo([altNovoPedido]);
    end;
  end;
end;

procedure TfrmPedidos.edtCdClienteChange(Sender: TObject);
begin

  lblCarregarPedido.Visible := edtCdCliente.Text = '' ;
  lblCancelarPedido.Visible := edtCdCliente.Text = '' ;
  shpCancelarPedido.Visible := edtCdCliente.Text = '' ;
  shpCarregarPedido.Visible := edtCdCliente.Text = '' ;
  lblNOPedido.Visible       := edtCdCliente.Text = '' ;
  edtpedido.Visible         := edtCdCliente.Text = '' ;

end;

procedure TfrmPedidos.edtCdClienteExit(Sender: TObject);
begin

  if novoPedido in FModo then
  begin
    if (edtCdCliente.Text <> '') then
    begin
      auxCliente := vCliente.GetCliente(StrToint(edtCdCliente.Text));

      if (auxCliente.retorno.sucess) then
      begin
        ID_Cliente         := auxCliente.ID_Cliente;
        edtNM_Cliente.Text := auxCliente.NM_Cliente;

        auxCliente.ID_Cliente := 0;
        auxCliente.NM_Cliente := '';
      end
      else
      begin
         Application.MessageBox(PChar(auxCliente.retorno.ErrMsg), 'Erro ao selecionar cliente', MB_OK + MB_ICONWARNING);
         edtNM_Cliente.Clear;
         edtCdCliente.SetFocus;
         edtCdCliente.SelectAll;
         exit;
      end;
    end;
  end;
end;

procedure TfrmPedidos.edtCdClienteKeyPress(Sender: TObject; var Key: Char);
begin
;
end;

procedure TfrmPedidos.edtCdProdutoExit(Sender: TObject);
begin
  if FID_Cliente > 0 then
  begin
    if edtCdProduto.Text <> '' then
    begin
      auxProdutos := vProdutos.GetProduto(StrToInt(edtCdProduto.Text));

      if (auxProdutos.retorno.sucess) then
      begin
        edtNM_Produto.Text  := auxProdutos.NM_Produto;
        edtVL_Unitario.Text := FloatToSTrf(auxProdutos.VL_Produto,ffNumber,18,2);

        if edtNO_Quantidade.Text = '' then
        begin
          edtNO_Quantidade.Text := '1';
        end;

        CalcVLTotal;
      end
      else
      begin
         Application.MessageBox(PChar(auxProdutos.retorno.ErrMsg), 'Erro ao selecionar produto', MB_OK + MB_ICONWARNING);
         ClearProduto;
         exit;
      end;
    end;
  end;
end;

procedure TfrmPedidos.edtNO_QuantidadeExit(Sender: TObject);
begin
  CalcVLTotal;
end;

procedure TfrmPedidos.edtpedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    OnClickCarregarPedido;
  end;
end;

procedure TfrmPedidos.edtVL_UnitarioExit(Sender: TObject);
var
  vl_unitario : real;
begin
  vl_unitario := MyStrToFloat(edtVL_Unitario.Text);

  edtVL_Unitario.Text := FloatToSTrf(vl_unitario,ffNumber,18,2);

  CalcVLTotal;
end;

procedure TfrmPedidos.edtVL_UnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    OnClickInserir;
  end;
end;

procedure TfrmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(vCliente);
  FreeAndNil(vProdutos);
end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  vCliente   := Clientes.Create;
  vProdutos  := Produtos.Create;
  vobjPedido := TobjPedido.Create;
end;



procedure TfrmPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if KEY = VK_F5 then
    OnClickConfirmar
  else if KEY = VK_F1 then
    OnClickNovoPedido;

end;

procedure TfrmPedidos.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  if key=#13 then
//    Perform(WM_nextdlgctl,0,0);

end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  setTPModo([novoPedido]);
end;

procedure TfrmPedidos.ItemAdd;
begin
  if auxProdutos.ID_Produto > 0 then
  begin
    cdsItens.Insert;
    cdsItens.FieldByName('ID_Produto').AsInteger    := auxProdutos.ID_Produto;
    cdsItens.FieldByName('NM_Produto').AsString     := auxProdutos.NM_Produto;
    cdsItens.FieldByName('NO_Quantidade').AsInteger := auxProdutos.NO_Quantidade;
    cdsItens.FieldByName('VL_Unidade').AsFloat      := auxProdutos.VL_Unidade;
    cdsItens.FieldByName('VL_Total').AsFloat        := auxProdutos.VL_Total;
    cdsItens.Post;

    cdsItens.Close;
    cdsItens.Open;

    auxProdutos.ID_Produto    := 0;
    auxProdutos.NM_Produto    := '';
    auxProdutos.NO_Quantidade := 0;
    auxProdutos.VL_Unidade    := 0;
    auxProdutos.VL_Total      := 0;
  end;
end;

procedure TfrmPedidos.Label17Click(Sender: TObject);
begin
  OnClickConfirmar;
end;

procedure TfrmPedidos.Label1Click(Sender: TObject);
begin
  OnClickNovoPedido;
end;

procedure TfrmPedidos.Label2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedidos.lblCancelaClick(Sender: TObject);
begin
  setTPModo(FModo_Old);
  setTPModo([novoPedido]);
end;

procedure TfrmPedidos.lblCancelarClick(Sender: TObject);
begin
  setTPModo(FModo_Old);
end;

procedure TfrmPedidos.lblCancelarPedidoClick(Sender: TObject);
begin
  if edtpedido.Text = '' then
     exit;

  CancelarPedido(StrToInt(edtPedido.Text));
end;

procedure TfrmPedidos.lblCarregarPedidoClick(Sender: TObject);
begin
  if edtpedido.Text = '' then
    exit;

  CarregarPedido(StrToInt(edtpedido.Text));
end;

procedure TfrmPedidos.lblInserirClick(Sender: TObject);
begin
  OnClickInserir;
end;

function TfrmPedidos.MyStrToFloat(s: string): real;
begin
  Result := StrToFloatDef(StringReplace(s, '.', '', [rfReplaceAll]),0);
end;

procedure TfrmPedidos.OnClickCarregarPedido;
begin
  info := 'Necessário informar um número de pedido';

  if edtpedido.Text = '' then
  begin
    info := 'Necessário informar um número de pedido';
    edtpedido.SetFocus;
    edtpedido.SelectAll;
    exit;
  end;

  CarregarPedido(StrToInt(edtpedido.Text));

end;

procedure TfrmPedidos.OnClickConfirmar;
var
  vPedido : TPedidos;
  vReturn : TRetorno;
begin
  if ID_Cliente = 0 then
  begin
    info := 'Sem informações de cliente.';
    exit;
  end;

  if altNovoPedido in FModo then
  begin
    info := 'Ação não permitida enquanto está alterando um lançamento.';
    edtNO_Quantidade.SetFocus;
    exit;
  end;

  if cdsItens.RecordCount <= 0 then
  begin
    info := 'Pedido sem itens cadastrados.';
    exit;
  end;

  vPedido.ID_Pedido  := ID_Pedido;
  if cdsItens.RecordCount > 0 then
    vPedido.VL_Pedido  := cdsItensTotal.Value
  else
    vPedido.VL_Pedido  := 0;

  vPedido.ID_Cliente := ID_Cliente;

  vReturn := vobjPedido.PedidoAddUpd(vPedido, cdsItens);

  if vReturn.sucess  then
  begin
    if vReturn.return_code > 0 then
    begin
      Application.MessageBox(PChar('Pedido N.:' + IntToStr(vReturn.return_code)+ ' inserido com sucesso!'),
        'Pedido Inserido com sucesso', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
       Application.MessageBox(PChar('Pedido atualizado com sucesso!'),
        'Pedido Atualizado com sucesso', MB_OK + MB_ICONINFORMATION);
    end;

  end;

  setTPModo([novoPedido]);
end;

procedure TfrmPedidos.OnClickInserir;
begin

  CalcVLTotal;

  if FID_Cliente > 0 then
  begin

    if auxProdutos.ID_Produto > 0 then
    begin

      if StrToInt(edtNO_Quantidade.Text) > 0 then
      begin

        auxProdutos.NO_Quantidade := StrToInt(edtNO_Quantidade.Text);
        auxProdutos.VL_Unidade    := MyStrToFloat(edtVL_Unitario.Text);
        auxProdutos.VL_Total      := MyStrToFloat(edtVL_Total.Text);

        if altNovoPedido in FModo then
        begin
          setTPModo([novoPedido]);
        end
        else
        begin
          ItemAdd;
          ClearProduto;
        end;

      end;
    end;
  end;
end;

procedure TfrmPedidos.OnClickNovoPedido;
begin
  setTPModo(FModo_Old);
  setTPModo([novoPedido]);
end;

procedure TfrmPedidos.setID_Cliente(ID_Cliente: Integer);
begin
  FID_Cliente := ID_Cliente;
  cdsItens.EmptyDataSet;
  ClearProduto;

  if FID_Cliente = 0 then
  begin
    edtCdCliente.Text  := '';
    edtNM_Cliente.Text := '';
  end;
end;

procedure TfrmPedidos.setID_Pedido(ID_Pedido: Integer);
var
  qryAux : TFDQuery;
begin
  FID_Pedido := ID_Pedido;

  if FID_Pedido = 0 then
    exit;

  setTPModo([carregaPedido]);

  qryAux            := TFDQuery.Create(nil);
  qryAux.Connection := frmDM.Con;

  qryAux := vobjPedido.GetPedidoItens(FID_Pedido);

  if qryAux.RecordCount > 0 then
  begin
    while not qryAux.Eof do
    begin
      auxProdutos.ID_Produto    := qryAux.FieldByName('ID_Produto').AsInteger;
      auxProdutos.VL_Unidade    := qryAux.FieldByName('VL_Unitario').AsFloat;
      auxProdutos.NO_Quantidade := qryAux.FieldByName('NO_Quantidade').AsInteger;
      auxProdutos.VL_Total      := qryAux.FieldByName('VL_Total').AsFloat;
      auxProdutos.NM_Produto    := vProdutos.GetProduto(auxProdutos.ID_Produto).NM_Produto;
      ItemAdd;
      qryAux.Next;
    end;
  end;

end;

procedure TfrmPedidos.setInfo(AInfo: string);
begin
  FInfo := AInfo;

  lblInfo2.Caption := AInfo;
  lblInfo2.Visible := AInfo <> '';
end;

procedure TfrmPedidos.setTPModo(ATipoModo: TModos);
begin

  FModo_Old := FModo;

  FModo                  := ATipoModo;
  lblCancelar.Visible    := False;
  lblInserir.Caption     := 'Inserir';

  info := '';

  if ((carregaPedido in FModo) and (altNovoPedido in FModo_Old)) then
  begin
    ItemAdd;
    ClearProduto;
    auxProdutos.ID_Produto := 0;
    auxProdutos.NM_Produto := '';
    lblInserir.Caption     := 'Inserir';
    lblCancelar.Visible    := false;
    edtCdProduto.ReadOnly  := False;
  end
  else if (carregaPedido in FModo) then
  begin
    lblInfo.Caption := 'Alterando pedido N. ' + IntToStr(FID_Pedido);
    edtCdCliente.ReadOnly := True;
  end;

  if ((novoPedido in FModo) and (altNovoPedido in FModo_Old)) then
  begin
    ItemAdd;
    ClearProduto;
    auxProdutos.ID_Produto := 0;
    auxProdutos.NM_Produto := '';
    lblInserir.Caption     := 'Inserir';
    lblCancelar.Visible    := false;
    edtCdProduto.ReadOnly  := False;
  end
  else
  if (novoPedido in FModo) then
  begin
    ClearProduto;
    cdsItens.EmptyDataSet;
    ID_Cliente             := 0;
    ID_Pedido              := 0;
    auxCliente.ID_Cliente  := 0;
    auxCliente.NM_Cliente  := '';
    auxProdutos.ID_Produto := 0;
    auxProdutos.NM_Produto := '';
    edtCdCliente.SetFocus;
    lblInfo.Caption       := 'Cadastrando novo pedido.';
    edtCdCliente.ReadOnly := False;
    edtCdProduto.ReadOnly := False;
    edtpedido.Text        := '';
  end
  else if (altNovoPedido in FModo) then
  begin
    lblInserir.Caption    := 'Gravar';
    lblCancelar.Visible   := true;
    edtCdProduto.ReadOnly := true;
  end;

end;

procedure TfrmPedidos.Shape10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  setTPModo(FModo_Old);
  setTPModo([novoPedido]);
end;

procedure TfrmPedidos.Shape11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  OnClickConfirmar;
end;

procedure TfrmPedidos.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corClick;
end;

procedure TfrmPedidos.Shape1MouseEnter(Sender: TObject);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corSecudaria;
end;

procedure TfrmPedidos.Shape1MouseLeave(Sender: TObject);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corPrimaria;
end;

procedure TfrmPedidos.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corPrimaria;
  OnClickNovoPedido;
end;

procedure TfrmPedidos.Shape2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Close;
end;

procedure TfrmPedidos.Shape7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorBotton.corClick;
end;

procedure TfrmPedidos.Shape7MouseEnter(Sender: TObject);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorBotton.corSecudaria;
end;

procedure TfrmPedidos.Shape7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorBotton.corPrimaria;
   OnClickInserir;
end;

procedure TfrmPedidos.shpCancelarPedidoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if edtpedido.Text = '' then
   begin
      Info := 'Necessário informar um número de pedido';
      edtpedido.SetFocus;
     exit;
   end;

   info := '';
   CancelarPedido(StrToInt(edtPedido.Text));
end;

procedure TfrmPedidos.shpCarregarPedidoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OnClickCarregarPedido;
end;

end.
