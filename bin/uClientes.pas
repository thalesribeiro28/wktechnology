unit uClientes;

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

type TCliente = object
  ID_Cliente : Integer;
  NM_Cliente : String;
  NM_Cidade  : String;
  NM_UF      : String;
  retorno    : TRetorno;
end;



type Clientes = class(TComponent)
  constructor Create;
  destructor Destroy;
  private
    qryClientes : TFDQuery;
  public
    function GetCliente(ID_Cliente : Integer) : TCliente;
end;


implementation

{ Pedidos }

uses uDM;


{ Clientes }

constructor Clientes.Create;
begin
  qryClientes            := TFDQuery.Create(nil);
  qryClientes.Connection := frmDM.Con;
end;

destructor Clientes.Destroy;
begin
  FreeAndNil(qryClientes);
end;

function Clientes.GetCliente(ID_Cliente: Integer): TCliente;
begin

  try

    qryClientes.Close;
    qryClientes.SQL.Clear;
    qryClientes.SQL.Add('SELECT ID_Cliente, NM_Cliente, NM_Cidade, NM_UF FROM CLIENTES');
    qryClientes.SQL.Add('WHERE ID_Cliente= :ID_Cliente');
    qryClientes.ParamByName('ID_Cliente').AsInteger := ID_Cliente;
    qryClientes.Open;

  except on e:Exception do
    begin
      result.retorno.return_code := 2;
      result.retorno.ErrMsg      := e.Message;
      result.retorno.sucess      := false;
      exit;
    end;
  end;

  if (qryClientes.RecordCount <= 0) then
  begin
    result.retorno.return_code := 1;
    result.retorno.ErrMsg      := 'Cliente não localizado.';
    result.retorno.sucess      := false;
  end
  else
  begin
    result.ID_Cliente := qryClientes.FieldByName('ID_Cliente').AsInteger;
    result.NM_Cliente := qryClientes.FieldByName('NM_Cliente').AsString;
    result.NM_Cidade  := qryClientes.FieldByName('NM_Cidade').AsString;
    result.NM_UF      := qryClientes.FieldByName('NM_UF').AsString;

    result.retorno.return_code := 0;
    result.retorno.ErrMsg      := '';
    result.retorno.sucess      := true;
  end;

  qryClientes.Close;
end;

end.

