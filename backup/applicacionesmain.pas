unit Applicacionesmain;

{$mode objfpc}{$H+}

{$ifdef Linux}{$ifdef CPUARM}
  {$define Android}
{$endif}{$endif}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  StrUtils,
  customdrawnint,
  LCLIntf,
  customdrawncontrols,
  customdrawndrawers,
  customdrawn_common,
  ParseMath,
  lazdeviceapis, MaskEdit, Grids, Laz_And_Controls,Unit1;

type

  { TfrmApplicacionesMain }

  TfrmApplicacionesMain = class(TForm)
    CDButton1: TCDButton;
    CDButton3: TCDButton;
    CDEdit1: TCDEdit;
    CDEdit3: TCDEdit;
    CDEdit4: TCDEdit;
    CDRadioButton1: TCDRadioButton;
    CDRadioButton2: TCDRadioButton;
    CDStaticText1: TCDStaticText;
    CDStaticText2: TCDStaticText;
    CDStaticText3: TCDStaticText;
    CDStaticText4: TCDStaticText;
    Ecuacion: TCDEdit;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    procedure CDButton1Click(Sender: TObject);
    procedure CDButton2Click(Sender: TObject);
    procedure CDButton3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Mostrar(rows1,cols2:Integer;res:matriz);
  private
    procedure MyOnListViewDialogResult(ASelectedItem: Integer);
    procedure Ejecutar;
  public
  end;

var
  frmApplicacionesMain: TfrmApplicacionesMain;
  tics, timerTics : integer;

implementation

{$R *.lfm}

{ TfrmApplicacionesMain }

procedure TfrmApplicacionesMain.FormCreate(Sender: TObject);
begin
  tics := 0;
  timerTics := 0;
end;

procedure TfrmApplicacionesMain.RadioGroup1Click(Sender: TObject);
begin

end;

procedure TfrmApplicacionesMain.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
end;

procedure TfrmApplicacionesMain.Ejecutar;
var
  MetodoCerrado:TMetodosCerrados;
  a,b,EX:real;
  funcion,r:string;
begin
  if RadioGroup1.ItemIndex<0 then
     exit();

  a:=StrToFloat(CDEdit1.Text);
  b:=StrToFloat(CDEdit4.Text);
  EX:=StrToFloat(CDEdit3.Text);
  funcion:=Ecuacion.Text;
  MetodoCerrado:=TMetodosCerrados.Create(funcion);
  MetodoCerrado.OPType:=RadioGroup1.ItemIndex;
  case MetodoCerrado.OPType of
       M_BISECCION: r:='Bisección f(x)=';
       M_FALSAPOSICION: r:='Falsa Posición f(x)=';
  end;
  MetodoCerrado.Executar(a,b,EX);
  {if CDRadioButton1.Checked then MetodoCerrado.MBiseccion(a,b,EX);
  if CDRadioButton2.Checked then MetodoCerrado.MFalsaPosicion(a,b,EX);}
  stringGrid1.RowCount:=MetodoCerrado.i+1;
  stringGrid1.ColCount:=5;
  CDStaticText1.Caption:=r+FloatToStr(MetodoCerrado.Resultado);
  Mostrar(MetodoCerrado.i+1,5,MetodoCerrado.M);
  MetodoCerrado.Destroy;

end;

procedure TfrmApplicacionesMain.CDButton1Click(Sender: TObject);
var
  MetodoCerrado:TMetodosCerrados;
  a,b,EX:real;
  bolz,funcion:string;
  Parse:TParseMath;

begin
  bolz:='f(a)=';
  Parse:=TParseMath.create();
  Parse.Expression:=Ecuacion.Text;
  Parse.AddVariable('x',0);
  Parse.NewValue('x',StrToFloat(CDEdit1.Text));
  bolz:=bolz+FloatToStr(Parse.Evaluate());

  Parse.NewValue('x',StrToFloat(CDEdit4.Text));
  bolz:=bolz+'   f(b)='+FloatToStr(Parse.Evaluate());


  a:=StrToFloat(CDEdit1.Text);
  b:=StrToFloat(CDEdit4.Text);
  EX:=StrToFloat(CDEdit3.Text);
  funcion:=Ecuacion.Text;
  MetodoCerrado:=TMetodosCerrados.Create(funcion);
  if CDRadioButton1.Checked then MetodoCerrado.MBiseccion(a,b,EX);
  if CDRadioButton2.Checked then MetodoCerrado.MFalsaPosicion(a,b,EX);
  stringGrid1.RowCount:=MetodoCerrado.i+1;
  stringGrid1.ColCount:=5;


  CDStaticText1.Caption:='f(x)='+FloatToStr(MetodoCerrado.Resultado);
  Mostrar(MetodoCerrado.i+1,5,MetodoCerrado.M);
  MetodoCerrado.Destroy;
end;



procedure TfrmApplicacionesMain.CDButton2Click(Sender: TObject);
begin
  {$ifdef LCLCustomDrawn}
    LCLIntf.OnListViewDialogResult := @MyOnListViewDialogResult;
    CDWidgetSet.ShowListViewDialog('',
      ['StartTimer', 'StopTimer', 'Exit'],
      ['', '', '']);
  {$endif}
end;

procedure TfrmApplicacionesMain.CDButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmApplicacionesMain.Edit1Change(Sender: TObject);
begin

end;

procedure TfrmApplicacionesMain.MyOnListViewDialogResult(ASelectedItem: Integer);
begin
end;

procedure TfrmApplicacionesMain.Timer1Timer(Sender: TObject);
begin
end;

procedure TfrmApplicacionesMain.Mostrar(rows1,cols2:Integer;res:matriz);
var
  i,j : Integer;
begin
     for i:=1 to rows1-1 do
         for j:=0 to cols2-1 do
             StringGrid1.Cells[j,i] := res[i-1,j];
end;

end.

