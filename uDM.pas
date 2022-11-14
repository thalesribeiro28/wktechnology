unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Comp.UI;

type
  TColorMenu  = object
    const corPrimaria  = $003D23ED;
    const corSecudaria = $004225FA;
    const corClick     = $001D106E;
  end;

  TColorBottonConfirma = object
    const corPrimaria  = $00BAED0C;
    const corSecudaria = $00BAED0C;
    const corClick     = $00BAED0C;
  end;

type
  TfrmDM = class(TDataModule)
    Con: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vColorMenu   : TColorMenu;
    vColorBotton : TColorBottonConfirma;
  end;

var
  frmDM: TfrmDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmDM.DataModuleCreate(Sender: TObject);
begin
  Con.Connected := true;
end;

end.
