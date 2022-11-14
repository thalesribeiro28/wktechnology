unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;


type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlMenu: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Shape4: TShape;
    Label5: TLabel;
    StatusBar1: TStatusBar;
    procedure Shape1MouseEnter(Sender: TObject);
    procedure Shape1MouseLeave(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1Click(Sender: TObject);
    procedure Shape4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uDM, uPedidos;

procedure TfrmMain.Label1Click(Sender: TObject);
begin
  frmPedidos := TfrmPedidos.Create(self);
  frmPedidos.ShowModal();

  FreeAndNil(frmPedidos)
end;

procedure TfrmMain.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corClick;

end;

procedure TfrmMain.Shape1MouseEnter(Sender: TObject);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corSecudaria;
end;

procedure TfrmMain.Shape1MouseLeave(Sender: TObject);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corPrimaria;
end;

procedure TfrmMain.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TShape).Brush.Color := frmDM.vColorMenu.corPrimaria;

  frmPedidos := TfrmPedidos.Create(self);
  frmPedidos.ShowModal();

  FreeAndNil(frmPedidos)
end;

procedure TfrmMain.Shape4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Application.Terminate;
end;

end.
