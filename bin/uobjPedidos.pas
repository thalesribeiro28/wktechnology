unit uobjPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClientes;


type TRetorno = object
  return_code : integer;
  ErrMsg      : string;
  sucess      : boolean;
end;

type TPedidos = object
  ID_Pedido  : Integer;
  DT_Emissao : TDate;
  VL_Pedido  : real;
  ID_Cliente : Integer;
  cliente    : TCliente;

  retorno    : TRetorno;
end;


type TobjPedido = class(TComponent)
  constructor Create;
  destructor Destroy;
  private
    qryPedidos : TFDQuery;
    qryPedidosItens : TFDQuery;
    function GetUltimoPedido:Integer;
  public
    function GetPedido(ID_Pedido : Integer) : TPedidos;
    function GetPedidoItens(ID_Pedido : Integer) : TFDQuery;
    function PedidoAddUpd(vPedido : TPedidos; cdsItens : TClientDataSet) : TRetorno;
    function PedidoDel(ID_Pedido : Integer) : TRetorno;
end;


implementation

{ Pedidos }

uses uDM;

{ TobjPedido }

constructor TobjPedido.Create;
begin
  qryPedidos            := TFDQuery.Create(nil);
  qryPedidos.Connection := frmDM.Con;

  qryPedidosItens            := TFDQuery.Create(nil);
  qryPedidosItens.Connection := frmDM.Con;
end;

destructor TobjPedido.Destroy;
begin
  FreeAndNil(qryPedidos);
  FreeAndNil(qryPedidosItens);
end;

function TobjPedido.GetPedido(ID_Pedido: Integer): TPedidos;
begin
  result.retorno.sucess := False;

  if ID_Pedido > 0 then
  begin
    qryPedidos.Close;
    qryPedidos.SQL.Clear;
    qryPedidos.SQL.Add('SELECT ID_Pedido, DT_Emissao, VL_Pedido, ID_Cliente');
    qryPedidos.SQL.Add('FROM PEDIDOS');
    qryPedidos.SQL.Add('WHERE ID_Pedido =:ID_Pedido');
    qryPedidos.ParamByName('ID_Pedido').AsInteger := ID_Pedido;
    qryPedidos.Open;

    if qryPedidos.RecordCount > 0 then
    begin
      result.ID_Pedido      := qryPedidos.FieldByName('ID_Pedido').AsInteger;
      result.DT_Emissao     := qryPedidos.FieldByName('DT_Emissao').AsDateTime;
      result.VL_Pedido      := qryPedidos.FieldByName('VL_Pedido').AsFloat;
      result.ID_Cliente     := qryPedidos.FieldByName('ID_Cliente').AsInteger;
      result.retorno.sucess := true;
    end;
  end;
end;

function TobjPedido.GetPedidoItens(ID_Pedido: Integer): TFDQuery;
begin
  qryPedidosItens.Close;
  qryPedidosItens.SQL.Clear;
  qryPedidosItens.SQL.Add('SELECT ID_Pedido_Item, ID_Pedido, ID_Produto, VL_Unitario, NO_Quantidade, VL_Total ');
  qryPedidosItens.SQL.Add('FROM PEDIDOS_ITENS ');
  qryPedidosItens.SQL.Add('  WHERE ID_Pedido = :ID_Pedido ');
  qryPedidosItens.ParamByName('ID_Pedido').AsInteger := ID_Pedido;
  qryPedidosItens.Open();

  Result := qryPedidosItens;
end;

function TobjPedido.GetUltimoPedido: Integer;
begin
  qryPedidos.Close;
  qryPedidos.SQL.Clear;
  qryPedidos.SQL.Add('SELECT MAX(ID_Pedido) AS MAX_PEDIDO FROM PEDIDOS');
  qryPedidos.Open;


  result := qryPedidos.FieldByName('MAX_PEDIDO').AsInteger;
end;

function TobjPedido.PedidoAddUpd(vPedido: TPedidos;
  cdsItens: TClientDataSet): TRetorno;
var
  id_pedido : integer;
begin

  if vPedido.ID_Pedido > 0 then
  begin

    qryPedidos.Close;
    qryPedidos.SQL.Clear;
    qryPedidos.SQL.Add('UPDATE PEDIDOS');
    qryPedidos.SQL.Add('SET VL_Pedido = :VL_Pedido');
    qryPedidos.SQL.Add('WHERE ID_Pedido = :ID_Pedido');
    qryPedidos.ParamByName('ID_Pedido').AsInteger := vPedido.ID_Pedido;
    qryPedidos.ParamByName('VL_Pedido').AsFloat   := vPedido.VL_Pedido;
    qryPedidos.ExecSQL;

    qryPedidosItens.Close;
    qryPedidosItens.SQL.Clear;
    qryPedidosItens.SQL.Add('DELETE FROM PEDIDOS_ITENS WHERE ID_Pedido = :ID_Pedido');
    qryPedidosItens.ParamByName('ID_Pedido').AsInteger := vPedido.ID_Pedido;
    qryPedidosItens.ExecSQL;

    if cdsItens.RecordCount > 0 then
    begin
      cdsItens.First;
      while not cdsItens.Eof do
      begin
        qryPedidosItens.Close;
        qryPedidosItens.SQL.Clear;
        qryPedidosItens.SQL.Add('INSERT INTO PEDIDOS_ITENS (ID_Pedido, ID_Produto, VL_Unitario, NO_Quantidade, VL_Total)');
        qryPedidosItens.SQL.Add('VALUES (:ID_Pedido, :ID_Produto, :VL_Unitario, :NO_Quantidade, :VL_Total)');
        qryPedidosItens.ParamByName('ID_Pedido').AsInteger      := vPedido.ID_Pedido;
        qryPedidosItens.ParamByName('ID_Produto').AsInteger     := cdsItens.FieldByName('ID_Produto').AsInteger;
        qryPedidosItens.ParamByName('VL_Unitario').AsFloat      := cdsItens.FieldByName('VL_Unidade').AsFloat;
        qryPedidosItens.ParamByName('NO_Quantidade').AsInteger  := cdsItens.FieldByName('NO_Quantidade').AsInteger;
        qryPedidosItens.ParamByName('VL_Total').AsFloat         := cdsItens.FieldByName('VL_Total').AsFloat;
        qryPedidosItens.ExecSQL;

        cdsItens.Next;
      end;
    end;

    result.return_code := 0;
    result.sucess      := true;
    result.ErrMsg      := '';

  end
  else
  begin
    qryPedidos.Close;
    qryPedidos.SQL.Clear;
    qryPedidos.SQL.Add('INSERT INTO PEDIDOS (DT_Emissao, VL_Pedido, ID_Cliente)');
    qryPedidos.SQL.Add('VALUES (CURDATE(), :VL_Pedido, :ID_Cliente)');
    qryPedidos.ParamByName('VL_Pedido').AsFloat    := vPedido.VL_Pedido;
    qryPedidos.ParamByName('ID_Cliente').AsInteger := vPedido.ID_Cliente;
    qryPedidos.ExecSQL;

    id_pedido := GetUltimoPedido;

    if cdsItens.RecordCount > 0 then
    begin
      cdsItens.First;
      while not cdsItens.Eof do
      begin
        qryPedidosItens.Close;
        qryPedidosItens.SQL.Clear;
        qryPedidosItens.SQL.Add('INSERT INTO PEDIDOS_ITENS (ID_Pedido, ID_Produto, VL_Unitario, NO_Quantidade, VL_Total)');
        qryPedidosItens.SQL.Add('VALUES (:ID_Pedido, :ID_Produto, :VL_Unitario, :NO_Quantidade, :VL_Total)');
        qryPedidosItens.ParamByName('ID_Pedido').AsInteger      := id_pedido;
        qryPedidosItens.ParamByName('ID_Produto').AsInteger     := cdsItens.FieldByName('ID_Produto').AsInteger;
        qryPedidosItens.ParamByName('VL_Unitario').AsFloat      := cdsItens.FieldByName('VL_Unidade').AsFloat;
        qryPedidosItens.ParamByName('NO_Quantidade').AsInteger  := cdsItens.FieldByName('NO_Quantidade').AsInteger;
        qryPedidosItens.ParamByName('VL_Total').AsFloat         := cdsItens.FieldByName('VL_Total').AsFloat;
        qryPedidosItens.ExecSQL;

        cdsItens.Next;
      end;
    end;

    result.return_code := id_pedido;
    result.sucess      := true;
    result.ErrMsg      := '';

  end;
end;

function TobjPedido.PedidoDel(ID_Pedido: Integer): TRetorno;
begin
  qryPedidosItens.Close;
  qryPedidosItens.SQL.Clear;
  qryPedidosItens.SQL.Add('DELETE FROM PEDIDOS_ITENS WHERE ID_Pedido = :ID_Pedido');
  qryPedidosItens.ParamByName('ID_Pedido').AsInteger := ID_Pedido;
  qryPedidosItens.ExecSQL;

  qryPedidos.Close;
  qryPedidos.SQL.Clear;
  qryPedidos.SQL.Add('DELETE FROM PEDIDOS WHERE ID_Pedido = :ID_Pedido');
  qryPedidos.ParamByName('ID_Pedido').AsInteger := ID_Pedido;
  qryPedidos.ExecSQL;

  result.sucess      := true;
  result.ErrMsg      := '';
end;

end.
