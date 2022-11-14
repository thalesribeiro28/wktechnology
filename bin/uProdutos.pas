unit uProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type TRetorno = object
  return_code : integer;
  ErrMsg      : string;
  sucess      : boolean;
end;

type TProduto = object
  ID_Produto    : Integer;
  NM_Produto    : String;
  VL_Produto    : Real;
  NO_Quantidade : Integer;
  VL_Unidade    : real;
  VL_Total      : Real;
  retorno       : TRetorno;
end;



type Produtos = class(TComponent)
  constructor Create;
  destructor Destroy;
  private
    qryProduto : TFDQuery;
  public
    function GetProduto(ID_Produto : Integer) : TProduto;
end;


implementation

{ Pedidos }

uses uDM;


{ Clientes }

constructor Produtos.Create;
begin
  qryProduto            := TFDQuery.Create(nil);
  qryProduto.Connection := frmDM.Con;
end;

destructor Produtos.Destroy;
begin
  FreeAndNil(qryProduto);
end;

function Produtos.GetProduto(ID_Produto: Integer): TProduto;
begin

  try

    qryProduto.Close;
    qryProduto.SQL.Clear;
    qryProduto.SQL.Add('SELECT ID_Produto, NM_Produto, VL_Produto FROM PRODUTOS');
    qryProduto.SQL.Add('WHERE ID_Produto= :ID_Produto');
    qryProduto.ParamByName('ID_Produto').AsInteger := ID_Produto;
    qryProduto.Open;

  except on e:Exception do
    begin
      result.retorno.return_code := 2;
      result.retorno.ErrMsg      := e.Message;
      result.retorno.sucess      := false;
      exit;
    end;
  end;

  if (qryProduto.RecordCount <= 0) then
  begin
    result.retorno.return_code := 1;
    result.retorno.ErrMsg      := 'Produto não localizado.';
    result.retorno.sucess      := false;
  end
  else
  begin
    result.ID_Produto := qryProduto.FieldByName('ID_Produto').AsInteger;
    result.NM_Produto := qryProduto.FieldByName('NM_Produto').AsString;
    result.VL_Produto := qryProduto.FieldByName('VL_Produto').AsFloat;

    result.retorno.return_code := 0;
    result.retorno.ErrMsg      := '';
    result.retorno.sucess      := true;
  end;

  qryProduto.Close;
end;

end.

