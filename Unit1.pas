unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Math, Qt;

const
  //Отступы на изображении(слева и справа)
  Space = 50;
  rad_arc = 20;
  strelk = 20;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit9: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Button1: TButton;
    Button2: TButton;
    TrackBar1: TTrackBar;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);//Кнопка "Моделировать"
    Function ConvertStrToFloat(s:string; var r:real): Boolean;//Проверка введённых чисел
    procedure Button2Click(Sender: TObject);//Кнопка "Очистить"
    procedure ComboBox1Change(Sender: TObject);//Изменение выпадающего списка
    procedure ChangeMode();//Изменение режима моделирования
    function Change2(n:integer):real;//Изменение показателя преломления
    procedure Calculations();//Расчёты
    procedure Ochistka();//Очистка изображения
    //Одиночное пересечение
    procedure DrawSingle(Y,centr_x,border:integer; shir, a_deg, a_rad,b_deg, b_rad, x:real; color_a, color_b : TColor; isFirst : Boolean);
    procedure DrawSingleObrat(Y, centr_x, border:integer; shir, a_deg, a_rad, b_deg, b_rad, x:real; color_a, color_b : TColor);
    //Три среды
    procedure Draw2(shir, x: real; cl1,cl2,cl3: TColor);
    //Четыре среды
    procedure Draw3(shir, x: real; cl1,cl2,cl3,cl4: TColor);
    procedure FormResize(Sender: TObject);//Масштабирование изображения
    procedure arc90_90(x,y,centr_shir:integer);
    //создание арок при угле 90 градусов
    procedure arc_90(x,y,centr_shir:integer; a_deg,a_rad:real);
    procedure arc(x,y,centr_shir:integer; a_deg, a_rad:real; b_deg, b_rad:real);
    procedure arc_otr(x,y,centr_shir:integer;a_deg,a_rad:real);
    procedure arc_obr(x,y,centr_shir:integer; a_deg, a_rad:real; b_deg, b_rad:real);
    procedure TrackBar1Change(Sender: TObject);
    //моделирование
    procedure Model();
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure strelka(x1, y1, x2, y2: integer; s_deg:real; col: TColor);
    procedure chk_color(x: real; cl1: TColor; var _RGB: TColor);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

    n1, n2, n3, n4 :real;
    x1_2, x2_3, x3_4 :real;
    a1_deg, a2_deg, a3_deg, a4_deg: real;
    a1_rad, a2_rad, a3_rad, a4_rad: real;
    a1_pred, a2_pred, a3_pred: real;
    
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//-----------------------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject);
begin
  ChangeMode();
end;

//-----------------------------------------------------------------------------------------
//моделирование
procedure TForm1.Model();
begin

  if not ConvertStrToFloat(Edit1.Text,n1) then
    exit;
  if not ConvertStrToFloat(Edit2.Text,n2) then
    exit;
  if not ConvertStrToFloat(Edit3.Text,n3) then
    exit;
  if not ConvertStrToFloat(Edit9.Text,a1_deg) then
    exit;

  //Очистка
  Ochistka();
  case ComboBox1.ItemIndex of
    0:
    begin
      Calculations();

      DrawSingle(Image1.Height div 2,Image1.Width div 2,
                 (Image1.Width - 2* space) div 2, Image1.Height / 2,a1_deg ,a1_rad,a2_deg, a2_rad, x1_2,clRed, clYellow, true);
    end;
    1:
    begin
      //Расчёт
      Calculations();
      Draw2(Image1.Height / 3, x1_2,clRed,clblue,clGreen);
    end;
    2:
    begin
      //Расчёт
      Calculations();
      Draw3(Image1.Height / 4, x1_2,clRed,clBlue,clGreen,clYellow);
    end;
  end;


end;

//-----------------------------------------------------------------------------------------
//
procedure TForm1.Button1Click(Sender: TObject);
begin
  //моделирование
  Model();
end;


//-----------------------------------------------------------------------------------------
//Очистка
procedure TForm1.Ochistka();
var
  a : TRect;
begin
  a.Left := 0;
  a.Top := 0;
  a.Right :=Image1.Width ;
  a.Bottom := Image1.Height;
  Image1.Canvas.FillRect(a);
end;


//-----------------------------------------------------------------------------------------
//Расчёт всех значений
procedure TForm1.Calculations();
var
 arc_a : real;
begin

  Case ComboBox1.ItemIndex of
  0:Label10.Visible := True;
  1:begin
    Label10.Visible := True;
    Label11.Visible := True;
    end;
  2:begin
    Label10.Visible := True;
    Label11.Visible := True;
    Label12.Visible := True;
    end;
  end;


  //проверка на 90 градусов - первый угол
  if a1_deg = 90 then
  begin
    Edit5.Text := 'Луч не прошёл';
    Edit6.Text := 'Луч не прошёл';
    Edit7.Text := 'Луч не прошёл';
    Label10.Visible := False;
    label11.Visible := False;
    Label12.Visible := False;
    a2_deg := -1;
    a3_deg := -1;
    a4_deg := -1;
    exit;
  end;

  if Abs(n2/n1) <= 1 then
    a1_pred := ArcSin(n2 / n1)
  else
    a1_pred := pi;

  //-----------------------------------
  //Попадание во вторую среду
  a1_rad := a1_deg * pi / 180; //Перевод в радианы

  //Расчитываем значение sin второй среды
  arc_a := n1 / n2 * sin(a1_rad);

  if Abs(n3/n2) <= 1 then
    a2_pred := ArcSin(n3 / n2)
  else
    a2_pred := pi;
  //Проверка
  if arc_a > 1 then
  begin
    Edit5.Text := 'Луч отразился';
    Edit6.Text := 'Луч не прошёл';
    Edit7.Text := 'Луч не прошёл';
    Label10.Visible := False;
    label11.Visible := False;
    Label12.Visible := False;
    a2_deg := -1;
    a3_deg := -1;
    a4_deg := -1;
    exit;
  end;

  //----------------------------
  //Нахождения угла для 2-ой среды
  a2_rad := ArcSin(arc_a);
  a2_deg := a2_rad * 180 / pi; //Перевод в градусы
  Edit5.Text := FloatToStr(a2_deg);

  //проверка на 90 градусов - первый выходящий угол
  if a2_deg = 90 then
  begin
    Edit6.Text := 'Луч не прошёл';
    Edit7.Text := 'Луч не прошёл';
    label11.Visible := False;
    Label12.Visible := False;
    a3_deg := -1;
    a4_deg := -1;
    exit;
  end;

  //-------------------------------
  //Расчитываем значение sin третьей среды
  arc_a := n2 / n3 * Sin(a2_rad);

  if Abs(n4/n3) <= 1 then
    a3_pred := ArcSin(n4 / n3)
  else
    a3_pred := pi;
  //Проверка
  if arc_a > 1 then
  begin
    Edit6.Text := 'Луч отразился';
    Edit7.Text := 'Луч не прошёл';
    label11.Visible := False;
    Label12.Visible := False;
    a3_deg := -1;
    a4_deg := -1;
    exit;
  end;

  if (ComboBox1.ItemIndex = 1) or (ComboBox1.ItemIndex = 2) then
  begin
    //----------------------------
    //Нахождение угла 3-ей среды
    a3_rad := ArcSin(arc_a);
    a3_deg := a3_rad * 180 / pi;
    Edit6.Text := FloatToStr(a3_deg);
    //проверка на 90 градусов - третий выходящий угол
    if a3_deg = 90 then
    begin
      Edit7.Text := 'Луч не прошёл';
      Label12.Visible := False;
      a4_deg := -1;
      exit;
    end;

    //Расчитываем значение sin четвёртой среды
    arc_a := n3 / n4 * Sin(a3_rad);
    if arc_a > 1 then
    begin
      Edit7.Text := 'Луч отразился';
      Label12.Visible := False;
      a4_deg := -1;
      exit;
    end;
  end;

  if ComboBox1.ItemIndex = 2 then
  begin
    //--------------------------------------------------------------------------------------
    //Нахождение угла 4-ой среды
    a4_rad := ArcSin(arc_a);
    a4_deg := a4_rad * 180 / pi;
    Edit7.Text := FloatToStr(a4_deg);
  end;

  if (a1_rad > a1_pred) then
    x1_2 := 1
  else
    x1_2 := a1_rad / a1_pred;

  if (a2_rad > a2_pred) then
    x2_3 := 1
  else
    x2_3 := a2_rad / a2_pred;

  if a3_rad > a3_pred then
    x3_4 := 1
  else
    x3_4 := a3_rad / a3_pred;


end;


//-----------------------------------------------------------------------------------------
//Проверка на ошибки при вводе
Function TForm1.ConvertStrToFloat(s:string; var r:real): Boolean;
begin
  r:=0;
  Try
    r := StrToFloat(S);
  Except
    Application.MessageBox('Введено не число', 'Ошибка пользователя', MB_OK);
    Result := false;
    exit;
  End;
  Result := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  a:TRect;
begin
  Ochistka();
end;


//-----------------------------------------------------------------------------------------
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  //Изменение режима
  ChangeMode();
  Model();
end;


//-----------------------------------------------------------------------------------------
//Изменение режима
procedure TForm1.ChangeMode();
begin
  //Проверка угла падения
  if not ConvertStrToFloat(Edit9.Text,a1_deg) then
    exit;


  //Проверка ввода коофициентов
  if RadioButton2.Checked then
  begin
  n1 := Change2(ComboBox2.ItemIndex);
  Edit1.Text := FloatToStr(n1);
  n2 := Change2(ComboBox3.ItemIndex);
  Edit2.Text := FloatToStr(n2);
  n3 := Change2(ComboBox4.ItemIndex);
  Edit3.Text := FloatToStr(n3);
  n4 := Change2(ComboBox5.ItemIndex);
  Edit4.Text := FloatToStr(n4);
  end
  else
  begin
    if not ConvertStrToFloat(Edit1.Text,n1) then
      exit;
    if not ConvertStrToFloat(Edit2.Text,n2) then
      exit;
    if not ConvertStrToFloat(Edit3.Text,n3) then
      exit;
    if not ConvertStrToFloat(Edit4.Text,n4) then
      exit;
  end;

  //Просматриваем режим моделирования
  case ComboBox1.ItemIndex of
    0: //2 среды
    begin
    //Скрытие ненужных компонентов
      Label7.Visible := False;
      Label8.Visible := False;
      Label11.Visible := False;
      Label12.Visible := False;
      Edit3.Visible := False;
      Edit4.Visible := False;
      Edit6.Visible := False;
      Edit7.Visible := False;
      ComboBox4.Visible := False;
      ComboBox5.Visible := False;

    end;
    1: //3 среды
    begin
    //Отображение нужных компонентов
      Label7.Visible := True;
      Label11.Visible := True;
      Edit3.Visible := True;
      if RadioButton2.Checked then
        Edit3.Enabled := False
      else
        Edit3.Enabled := True;
      Edit6.Visible := True;
      ComboBox4.Visible := True;
      if RadioButton2.Checked then
        ComboBox4.Enabled := True
      else
        ComboBox4.Enabled := False;

    //Скрытие ненужных компонентов
      Label8.Visible := False;
      Label12.Visible := False;
      Edit4.Visible := False;
      Edit7.Visible := False;
      ComboBox5.Visible := False;

    end;
    2: //4 среды
    begin
    //Отображение нужных элементов
      Label7.Visible := True;
      Label12.Visible := True;
      Edit3.Visible := True;
      Edit6.Visible := True;
      Edit7.Visible := True;
      Label8.Visible := True;
      Edit4.Visible := True;
      if RadioButton1.Checked then
      begin
        Edit4.Enabled := True;
        Edit3.Enabled := True;
      end
      else
      begin
        Edit4.Enabled := False;
        Edit3.Enabled := False;
      end;
      ComboBox4.Visible := True;
      ComboBox5.Visible := True;
      if RadioButton1.Checked then
      begin
        ComboBox4.Enabled := False;
        ComboBox5.Enabled := False;
      end
      else
      begin
        ComboBox4.Enabled := True;
        ComboBox5.Enabled := True;
      end;
    end;

  end;
end;


//-----------------------------------------------------------------------------------------
//Получение коофициента преломления
Function TForm1.Change2(n:integer):real;
begin
  case n of
  0: Result := 1; //вакуум
  1: Result := 1.3330; //Вода дист
  2: Result := 1.5014; //
  3: Result := 1.4730; //
  4: Result := 1.4290; //
  5: Result := 1.2540; //
  6: Result := 1.560; //
  7: Result := 1.470; //
  8: Result := 2.420; //Алмаз
  9: Result := 1.5163; //Стекло
  else Result := 1;
  end;
end;


//-----------------------------------------------------------------------------------------
//3 среды - Рисование
procedure TForm1.Draw2(shir, x: real; cl1,cl2,cl3:TColor);
var
  Len: real;
  centr_x, shir_i, centr_shir, l : integer;
  border: integer;
  _RGB : TColor;
begin

  Len := Tan(a2_rad) * shir;

  shir_i := Round(shir);
  centr_shir := round(shir / 2);
  centr_x := Image1.Width div 2;
  border := (Image1.Width - 2 * space) div 2;

  if a1_deg = 90 then
  begin
    Image1.Canvas.Pen.Color := cl1;
    Image1.Canvas.Pen.Width := 2;
    Image1.Canvas.MoveTo(0,shir_i);
    Image1.Canvas.LineTo(Image1.Width,shir_i);

    strelka(0,Shir_i,Image1.Width div 2,Shir_i, 0, cl1);
    strelka(Image1.Width div 2,Shir_i, Image1.Width,Shir_i, 0, cl1);

    arc90_90(centr_x,shir_i,centr_shir);
    Image1.Canvas.MoveTo(0,2 * shir_i);
    Image1.Canvas.LineTo(Image1.Width,2 * shir_i);
  end
  else
  if a2_deg = -1 then
  begin
    DrawSingle(shir_i,centr_x,border,shir_i,a1_deg,a1_rad,a2_deg,a2_rad, x1_2,cl1,cl2,true);

    Image1.Canvas.MoveTo(0,shir_i);
    Image1.Canvas.LineTo(Image1.Width,shir_i);

    Image1.Canvas.MoveTo(0, 2 * shir_i);
    Image1.Canvas.LineTo(Image1.Width, 2 * shir_i);
  end
  else
  begin
    if a3_deg = -1 then
    begin
      l := round((Image1.Width - Len) / 2);
      begin
        DrawSingle(Shir_i,centr_x div 2,border div 2,shir_i,a1_deg,a1_rad,a2_deg,a2_rad,x1_2,cl1,cl2,false);
        DrawSingle(shir_i * 2,centr_x,border,shir_i,a2_deg,a2_rad,a3_deg,a3_rad,x2_3,cl2,cl2,false);
        DrawSingleObrat(shir_i, centr_x * 3 div 2,border div 2, shir_i, a1_deg, a1_rad, a2_deg, a2_rad, x1_2, cl1, cl2);

        Image1.Canvas.MoveTo(0,shir_i);
        Image1.Canvas.LineTo(Image1.Width,shir_i);

        Image1.Canvas.MoveTo(0,shir_i * 2);
        Image1.Canvas.LineTo(Image1.Width,shir_i * 2);
      end;
    end
    else
    begin
      //Если рисунок не помещается --> два сингла
      if Len > (Image1.Width - Space * 2) then
      begin
        //Одиночное пересечение
        DrawSingle(shir_i,centr_x,border, shir,a1_deg, a1_rad,a2_deg, a2_rad, x1_2,cl1, cl2,true);
        //Одиночное пересечение
        DrawSingle(shir_i * 2,centr_x,border, shir,a2_deg, a2_rad,a3_deg, a3_rad, x2_3,cl2, cl3,false);
      end
      else
      begin
      //Первое преломление
        l := round((Image1.Width - Len) / 2);

        Image1.Canvas.Pen.Width := 2;
        Image1.Canvas.Pen.Color := cl1;
        Image1.Canvas.MoveTo(round(l),Round(Shir));
        Image1.Canvas.LineTo(round(l - (Tan(a1_rad) * centr_shir)),centr_shir);

        strelka(round(l), Round(Shir), round(l - (Tan(a1_rad) * centr_shir)), centr_shir, 270 + a1_deg, cl1);

        Image1.Canvas.Pen.Color := cl2;
        Image1.Canvas.MoveTo(round(l),round( Shir));
        Image1.Canvas.LineTo(round(l + (Tan(a2_rad) * Shir)),Round(Shir * 2));

        strelka(round(l), Round(Shir), round(l + (Tan(a2_rad) * Shir)), Round(Shir * 2), 270 + a2_deg, cl2);

        arc(l,shir_i,centr_shir,a1_deg,a1_rad,a2_deg,a2_rad);
        Image1.Canvas.MoveTo(0,Shir_i);
        Image1.Canvas.LineTo(Image1.Width,shir_i);

        //nep_otr
        if ((n1 <> n2) and (a1_deg > 0)) and CheckBox1.Checked then
        begin
          Image1.Canvas.Pen.Width := 2;
          chk_color(x,cl1, _RGB);
          Image1.Canvas.Pen.Color := _RGB;
          Image1.Canvas.MoveTo(round(l),Round(Shir));
          Image1.Canvas.LineTo(round(l + (Tan(a1_rad) * centr_shir)),centr_shir);
          strelka(round(l), Round(Shir), round(l + (Tan(a1_rad) * centr_shir)), centr_shir, -270 - a1_deg, _RGB);
        end;

        if a3_deg = 90 then
        begin
          Image1.Canvas.Pen.Color := cl2;
          Image1.Canvas.Pen.Width := 2;
          Image1.Canvas.MoveTo(round(l + (Tan(a2_rad) * Shir)),Round(Shir * 2));
          Image1.Canvas.LineTo(Image1.Width,shir_i * 2);

          strelka( round(l + (Tan(a2_rad) * Shir)), Round(Shir * 2), Image1.Width,shir_i * 2, 0, cl2);

          arc_90(round(l + (Tan(a2_rad) * Shir)),shir_i*2,centr_shir, a2_deg, a2_rad);
          Image1.Canvas.MoveTo(0,Shir_i* 2);
          Image1.Canvas.LineTo(Image1.Width,shir_i * 2);
        end
        else
        begin
          Image1.Canvas.Pen.Color := cl3;
          Image1.Canvas.Pen.Width := 2;
          Image1.Canvas.MoveTo(round(l + (Tan(a2_rad) * Shir)),Round(Shir * 2));
          Image1.Canvas.LineTo(Round((l + Len) + (Tan(a3_rad) * centr_shir)),round(shir * 5 /2));

          strelka(round(l + (Tan(a2_rad) * Shir)), Round(Shir * 2), Round((l + Len) + (Tan(a3_rad) * centr_shir)), round(shir * 5 /2), 270 + a3_deg, cl3);

          arc(round(l + (Tan(a2_rad) * Shir)), shir_i * 2,centr_shir,a2_deg,a2_rad,a3_deg,a3_rad);
          Image1.Canvas.MoveTo(0,Shir_i* 2);
          Image1.Canvas.LineTo(Image1.Width,shir_i * 2);
        end;
      end;
    end;
  end;
end;


//-----------------------------------------------------------------------------------------
//4 среды - Рисование
procedure TForm1.Draw3(shir, x: real; cl1,cl2,cl3,cl4:TColor);
var
  Len, l : real;
  centr_x, shir_i, centr_shir,border : integer;
  _RGB : TColor;
begin

  shir_i := Round(shir);
  centr_shir := round(shir / 2);
  Len := (Tan(a2_rad) * shir) + (Tan(a3_rad) * shir);
  border := (Image1.Width - 2 * space) div 2;
  centr_x := Image1.Width div 2;

  if (a3_deg = -1) or (a3_deg = 90) then
  begin
    Shir_i := Image1.Height div 3;
    Draw2(shir_i, x1_2,cl1,cl2,cl3);
  end
  else
  begin
    if a4_deg = -1 then
    begin
      l := Image1.Width div 10;

      DrawSingle(shir_i,centr_x div 3,Round(border / 2.3),shir,a1_deg,a1_rad,a2_deg,a2_rad, x1_2,cl1,cl2,true);
      DrawSingle(shir_i * 2,centr_x div 3 * 2 ,Round(border / 2.3),shir,a2_deg,a2_rad,a3_deg,a3_rad, x2_3,cl2,cl3,false);
      DrawSingle(Shir_I * 3,centr_x,Round(Border / 2.3),shir,a3_deg,a3_rad,a4_deg,a4_rad, x3_4,cl3,cl3,false);
      DrawSingleObrat(shir_i * 2,centr_x div 3 * 4,Round(border / 2.3),shir,a2_deg,a2_rad,a3_deg,a3_rad, x2_3,cl2,cl3);
      DrawSingleObrat(shir_i,centr_x div 3 * 5,Round(border / 2.3),shir,a1_deg,a1_Rad,a2_deg,a2_rad, x1_2,cl1,cl2);

      exit;
    end;

    //Помещается-ли рисунок полностью
    if Len < (Image1.Width - space * 2) then
    begin
      //Первое преломление
      l := round((Image1.Width - Len) / 2);

      Image1.Canvas.Pen.Width := 2;
      Image1.Canvas.Pen.Color := cl1;
      Image1.Canvas.MoveTo(round(l),Round(Shir));
      Image1.Canvas.LineTo(round(l - (Tan(a1_rad) * centr_shir)),centr_shir);

      strelka(round(l), Round(Shir), round(l - (Tan(a1_rad) * centr_shir)), centr_shir, 270 + a1_deg, cl1);

      Image1.Canvas.Pen.Color := cl2;
      Image1.Canvas.MoveTo(round(l),round( Shir));
      Image1.Canvas.LineTo(round(l + (Tan(a2_rad) * Shir)),Round(Shir * 2));

      strelka(round(l), round( Shir), round(l + (Tan(a2_rad) * Shir)),Round(Shir * 2), 270 + a2_deg, cl2);

      arc(Round(l),shir_i,centr_shir,a1_deg,a1_rad,a2_deg,a2_rad);
      Image1.Canvas.MoveTo(0,Shir_i);
      Image1.Canvas.LineTo(Image1.Width,shir_i);


      //nep_otr
      if ((n1 <> n2) and (a1_deg > 0)) and CheckBox1.Checked then
      begin
        chk_color(x,cl1, _RGB);
        Image1.Canvas.Pen.Color := _RGB;
        Image1.Canvas.Pen.Width := 2;
        Image1.Canvas.MoveTo(round(l),Round(Shir));
        Image1.Canvas.LineTo(round(l + (Tan(a1_rad) * centr_shir)),centr_shir);
        strelka(round(l), Round(Shir), round(l + (Tan(a1_rad) * centr_shir)), centr_shir, -270 - a1_deg, _RGB);
      end;

      //Второе преломление
      Image1.Canvas.Pen.Width := 2;
      Image1.Canvas.Pen.Color := cl3;
      Image1.Canvas.MoveTo(round(l + Tan(a2_rad) * Shir),Round(Shir * 2));
      Image1.Canvas.LineTo(Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i),round(shir * 3));

      strelka(round(l + Tan(a2_rad) * Shir), Round(Shir * 2), Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i),round(shir * 3), 270 + a3_deg, cl3);

      arc(Round(l+Tan(a2_rad) * Shir),shir_i * 2,centr_shir,a2_deg,a2_rad,a3_deg,a3_rad);
      Image1.Canvas.MoveTo(0,Shir_i * 2);
      Image1.Canvas.LineTo(Image1.Width,shir_i * 2);

      //Третье преломление
      Image1.Canvas.Pen.Width := 2;
      Image1.Canvas.Pen.Color := cl4;
      Image1.Canvas.MoveTo(Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i),round(shir * 3));
      Image1.Canvas.LineTo(Round(l + (Tan(a2_rad) * Shir) + (Tan(a3_rad) * Shir) + (Tan(a4_rad) * centr_shir)),round(shir * 7 / 2));

      strelka(Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i), round(shir * 3), Round(l + (Tan(a2_rad) * Shir) + (Tan(a3_rad) * Shir) + (Tan(a4_rad) * centr_shir)),round(shir * 7 / 2), 270 + a4_deg, cl4);

      arc(Round(l+Tan(a2_rad) * Shir+ Tan(a3_rad) * Shir),shir_i * 3,centr_shir,a3_deg,a3_rad,a4_deg,a4_rad);
      Image1.Canvas.MoveTo(0,Shir_i * 3);
      Image1.Canvas.LineTo(Image1.Width,shir_i * 3);
    end
    else
    //Не вмещается третье преломление
    if Tan(a2_rad) * shir < (Image1.Width - space * 2) then
    begin
      Draw2(shir, x1_2,cl1,cl2,cl3);
      DrawSingle(shir_i * 3,centr_x,border,shir,a3_deg,a3_rad,a4_deg,a4_rad,x3_4,cl3,cl4,false);
    end
    else
    //Рисунок не вмещается --> три сингла
    begin
      DrawSingle(shir_i,centr_x,border, shir,a1_deg, a1_rad,a2_deg, a2_rad, x1_2, cl1, cl2,true);
      DrawSingle(shir_i * 2,centr_x,border, shir,a2_deg, a2_rad,a3_deg, a3_rad, x2_3,cl2, cl3,false);
      DrawSingle(shir_i * 3,centr_x,border, shir,a3_deg, a3_rad, a4_deg, a4_rad, x3_4,cl3, cl4,false);
    end;
    if a4_deg = 90 then
    begin
      //Третье преломление
      Image1.Canvas.Pen.Width := 2;
      Image1.Canvas.Pen.Color := cl3;
      Image1.Canvas.MoveTo(Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i),round(shir * 3));
      Image1.Canvas.LineTo(Image1.Width,shir_i * 3);

      strelka(Round(l + Tan(a2_rad) * Shir + Tan(a3_rad) * shir_i), round(shir * 3), Image1.Width,shir_i * 3, 0 ,cl3); 
    end;
  end;
end;
//-----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------
//Одиночное пересечение
procedure TForm1.DrawSingle(Y, centr_x, border:integer; shir, a_deg, a_rad, b_deg, b_rad, x:real; color_a, color_b : TColor; isFirst : Boolean);
var
   centr_shir,start_x,end_x  : integer;
   _RGB : TColor;
begin
  centr_shir :=  round(shir / 2);

  Image1.Canvas.Pen.Width := 2;

  //проверка на 90 градусов
  if a_deg = 90 then
  begin
    //vhodnoy luch
    Image1.Canvas.Pen.Color := color_a;
    Image1.Canvas.MoveTo(space,y);
    Image1.Canvas.LineTo(centr_x,y);

    //vyhodyaschiy luch
    Image1.Canvas.Pen.Color := color_a;
    Image1.Canvas.LineTo(Image1.Width - space,y);

    strelka(Image1.Width div 4 + 20, Y, Image1.Width div 4 + 20, Y, 0, color_a);
    strelka(Image1.Width div 4 * 3, Y, Image1.Width div 4 * 3,  Y, 0, color_a);

    //Рисование угла
    arc90_90(centr_x,y,centr_shir);
    exit;
  end
  else
  if b_deg = -1 then
  begin
    //vhodnoy luch
    Image1.Canvas.Pen.Color := color_a;
    Image1.Canvas.MoveTo(centr_x, y);

    //ограничение  слева
    if Round((Tan(a_rad) * centr_shir)) > border then
    begin
     Image1.Canvas.LineTo(centr_x - border, Round(y - (border/Tan(a_rad))));
     strelka(centr_x - border, Round(y - (border/Tan(a_rad))), centr_x, y, 270 + a_deg, color_a);
    end
    else
    begin
     Image1.Canvas.LineTo(Round(centr_x - (Tan(a_rad) * centr_shir)), Round(y - centr_shir));
     strelka(Round(centr_x - (Tan(a_rad) * centr_shir)), Round(y - centr_shir), centr_x, y, 270 + a_deg, color_a);
    end;

    //vyhodyaschiy luch
    Image1.Canvas.Pen.Color := color_a;
    Image1.Canvas.MoveTo(centr_x, y);
    //ограничение справа
    if Round((Tan(a_rad) * centr_shir)) > border then
    begin
      Image1.Canvas.LineTo(centr_x + border, Round(y - (border/Tan(a_rad))));
      strelka(centr_x, Y, centr_x + border, Round(y - (border/Tan(a_rad))), -270 - a_deg, color_a);
    end
    else
    begin
      Image1.Canvas.LineTo(Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir));
      strelka(centr_x, Y, Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir), -270 - a_deg, color_a);
    end;


    arc_otr(centr_x,y,centr_shir, a_deg,a_rad);
    Image1.Canvas.MoveTo(0,y);
    Image1.Canvas.LineTo(Image1.Width,Y);
    exit;
  end
  else
  //norm sluchay
  begin
  //vhodnoy luch
    Image1.Canvas.Pen.Color := color_a;
    Image1.Canvas.MoveTo(centr_x, y);
    //ограничение  слева
    if Round((Tan(a_rad) * centr_shir)) > border then
    begin
      Image1.Canvas.LineTo(centr_x - border, Round(y - (border/Tan(a_rad))));
      strelka(centr_x, Y, centr_x - border, Round(y - (border/Tan(a_rad))), 270 + a_deg, color_a);

      if isFirst then
      begin
        //nep_otr
        if ((n1 <> n2) and (a_deg > 0)) and CheckBox1.Checked then
        begin
          chk_color(x,color_a, _RGB);
          Image1.Canvas.Pen.Color := _RGB;
          //Image1.Canvas.Pen.Color := RGB(255, Round(255*(1-x)), Round(255*(1-x)));
          Image1.Canvas.MoveTo(centr_x,y);
          Image1.Canvas.LineTo(centr_x + border, Round(y - (border/Tan(a_rad))));
          strelka(centr_x, Y, centr_x + border, Round(y - (border/Tan(a_rad))), -270 - a_deg, _RGB);
        end;
      end;  
    end
    else
    begin
      Image1.Canvas.LineTo(Round(centr_x - (Tan(a_rad) * centr_shir)), Round(y - centr_shir));
      strelka(centr_x, Y, Round(centr_x - (Tan(a_rad) * centr_shir)), Round(y - centr_shir), 270 + a_deg, color_a);

      if isFirst then
      begin
        //nep_otr
        if ((n1 <> n2) and (a_deg > 0)) and CheckBox1.Checked then
        begin
          chk_color(x,color_a, _RGB);
          Image1.Canvas.Pen.Color := _RGB;
          //Image1.Canvas.Pen.Color := RGB(255, Round(255*(1-x)), Round(255*(1-x)));
          Image1.Canvas.MoveTo(centr_x,y);
          Image1.Canvas.LineTo(Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir));
          strelka(centr_x, Y, Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir), -270 - a_deg, _RGB);
        end;
      end;
    end;




    //vyhodyaschiy luch
    Image1.Canvas.Pen.Color := color_b;
    if b_deg = 90 then
    begin
      Image1.Canvas.MoveTo(centr_x, y);
      Image1.Canvas.LineTo(Image1.Width - space,y);
      strelka(centr_x, Y, Image1.Width - space, y, 0, color_b);

      arc_90(centr_x,y,centr_shir, a_deg, a_rad);
      Image1.Canvas.MoveTo(0,y);
      Image1.Canvas.LineTo(Image1.Width,y);
      exit;
    end
    else
    begin
      Image1.Canvas.MoveTo(centr_x, y);
//    Image1.Canvas.Pen.Color := RGB(255, 255, Round(255*(x)));
      //ограничение справа
      if Round((Tan(b_rad) * centr_shir)) > border then
      begin
        Image1.Canvas.LineTo(centr_x + border, Round(y + (border/Tan(b_rad))));
        strelka(centr_x, Y, centr_x + border, Round(y + (border/Tan(b_rad))), 270 + b_deg, color_b);
      end
      else
      begin
        Image1.Canvas.LineTo(Round(centr_x + (Tan(b_rad) * centr_shir)), Round(y + centr_shir));
        strelka(centr_x, Y, Round(centr_x + (Tan(b_rad) * centr_shir)), Round(y + centr_shir), 270 + b_deg, color_b);
      end;

      arc(centr_x,y,centr_shir, a_deg, a_rad,b_deg,b_rad);
    end;
  end;
  Image1.Canvas.MoveTo(0,y);
  Image1.Canvas.LineTo(Image1.Width,Y);
end;


procedure TForm1.DrawSingleObrat(Y, centr_x,border:integer; shir, a_deg, a_rad, b_deg, b_rad, x:real; color_a, color_b : TColor);
var
  centr_shir : integer;
  _RGB : TColor;
begin
  centr_shir := round(shir / 2);

  Image1.Canvas.Pen.Width := 2;
  Image1.Canvas.Pen.Color := color_b;

  Image1.Canvas.MoveTo(Centr_x,Y);
  //ограничение  слева
  if Round((Tan(b_rad) * centr_shir)) > border then
  begin
    Image1.Canvas.LineTo(centr_x - border, Round(y + (border/Tan(b_rad))));
    strelka(Centr_x, Y, centr_x - border, Round(y + (border/Tan(b_rad))), - 270 - b_deg, color_b);
  end
  else
  begin
    Image1.Canvas.LineTo(Round(centr_x - (Tan(b_rad) * centr_shir)), Round(y + centr_shir));
    strelka(Centr_x, Y, Round(centr_x - (Tan(b_rad) * centr_shir)), Round(y + centr_shir), - 270 - b_deg, color_b);
  end;

  Image1.Canvas.Pen.Color := color_a;

  Image1.Canvas.MoveTo(Centr_x,Y);
  //ограничение справа
  if Round((Tan(a_rad) * centr_shir)) > border then
  begin
    Image1.Canvas.LineTo(centr_x + border, Round(y - (border/Tan(a_rad))));
    strelka(Centr_x, Y, centr_x + border, Round(y - (border/Tan(a_rad))), -270 - a_deg, color_a);
  end
  else
  begin
    Image1.Canvas.LineTo(Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir));
    strelka(Centr_x, Y, Round(centr_x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir), -270 - a_deg, color_a);
  end;

  arc_obr(centr_x,y,centr_shir, a_deg, a_rad, b_deg, b_rad);
end;

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//создание арок при угле 90 градусов
procedure TForm1.arc90_90(x,y,centr_shir:integer);
begin
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Pen.Color := clBlack;

  //Перпендекуляр
  Image1.Canvas.MoveTo(x, y - centr_shir );
  Image1.Canvas.LineTo(x,y + centr_shir );

  //для угла a
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, 0,
                    0,y);

  Image1.Canvas.TextOut(x - 35,y - 35,'90гр');

   //для угла b
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, y + 1,
                    x + 1 , y);
  Image1.Canvas.TextOut(x + 15,y + 15,'90гр');

end;

//-------------------------------------------------------------------------
//создание арок при угле 90 градусов
procedure TForm1.arc_90(x,y,centr_shir:integer; a_deg, a_rad:real);
var
  s:string;
begin
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Pen.Color := clBlack;

  //Перпендекуляр
  Image1.Canvas.MoveTo(x, y - centr_shir );
  Image1.Canvas.LineTo(x,y + centr_shir );

  //для угла a
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, 0,
                    round(x - (Tan(a_rad) * centr_shir)),y - centr_shir);
   s := FloatToStr(RoundTo(a_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x - 35,y - 35,s);

   //для угла b
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, y + 1,
                    x + 1 , y);

  Image1.Canvas.TextOut(x + 15,y + 15,'90гр');

end;

//-------------------------------------------------------------------------
//создание арок при угле 90 градусов
procedure TForm1.arc(x,y,centr_shir:integer; a_deg, a_rad:real; b_deg, b_rad:real);
var
  s :string;
begin
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Pen.Color := clBlack;

  //проверка на 0 градусов
  if a_deg = 0 then
  begin
    Image1.Canvas.TextOut(x - 35,y - 35,'0 гр');
    Image1.Canvas.TextOut(x + 15,y + 15,'0 гр');
    exit;
  end;


  //Перпендекуляр
  Image1.Canvas.MoveTo(x, y - centr_shir );
  Image1.Canvas.LineTo(x,y + centr_shir );

  //для угла a
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, 0,
                    round(x - (Tan(a_rad) * centr_shir)),y - centr_shir);
    s := FloatToStr(RoundTo(a_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x - 35,y - 35,s);

   //для угла b
   Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, y + 1,
                    round(x + (Tan(b_rad) * centr_shir)), Round(y + centr_shir));
   s := FloatToStr(RoundTo(b_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x + 15,y + 15,s);

end;

//-------------------------------------------------------------------------

procedure TForm1.arc_otr(x,y,centr_shir:integer; a_deg,a_rad:real);
var
  s:string;
begin
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Pen.Color := clBlack;

  //Перпендекуляр
  Image1.Canvas.MoveTo(x, y - centr_shir );
  Image1.Canvas.LineTo(x,y + centr_shir );

  //для угла a
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    x, 0,
                    round(x - (Tan(a_rad) * centr_shir)),y - centr_shir);

   //для угла b
  Image1.Canvas.Arc(x - rad_arc - 3, y - rad_arc - 3,
                    x + rad_arc + 3, y + rad_arc + 3,
                    round(x + (Tan(a_rad) * centr_shir)),y - centr_shir,
                    x  , 0);


  s := FloatToStr(RoundTo(a_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x - 35,y - 35,s);
  Image1.Canvas.TextOut(x + 15,y  - 35,s);
end;

//-------------------------------------------------------------------------

procedure TForm1.arc_obr(x,y,centr_shir:integer; a_deg, a_rad:real; b_deg, b_rad:real);
var
  s :string;
begin
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Pen.Color := clBlack;

  //Перпендекуляр
  Image1.Canvas.MoveTo(x, y - centr_shir );
  Image1.Canvas.LineTo(x,y + centr_shir );

  //для угла a
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    round(x + (Tan(a_rad) * centr_shir)), Round(y - centr_shir),
                    x, y - 1);


  //для угла b
  Image1.Canvas.Arc(x - rad_arc, y - rad_arc,
                    x + rad_arc, y + rad_arc,
                    round(x - (Tan(b_rad) * centr_shir)),y + centr_shir,
                    x, y + centr_shir);

  s := FloatToStr(RoundTo(a_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x + 10,y - 35,s);
  s := FloatToStr(RoundTo(b_deg,0)) + 'гр';
  Image1.Canvas.TextOut(x - 35,y + 35,s);
end;


//Масштабирование окна --> перерисовка изображения
procedure TForm1.FormResize(Sender: TObject);
begin
  Image1.Picture.Bitmap.Height := Image1.Height;
  Image1.Picture.Bitmap.Width := Image1.Width;

  //моделирование
  Model();
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  edit9.Text := IntToStr(TrackBar1.Position);
  //моделирование
  Model();

end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0:begin
    Edit1.Enabled := True;
    Edit2.Enabled := True;
    ComboBox2.Enabled := False;
    ComboBox3.Enabled := False;
    end;
  1:begin
    Edit1.Enabled := True;
    Edit2.Enabled := True;
    Edit3.Enabled := True;
    ComboBox2.Enabled := False;
    ComboBox3.Enabled := False;
    ComboBox4.Enabled := False;
    end;
  2:begin
    Edit1.Enabled := True;
    Edit2.Enabled := True;
    Edit3.Enabled := True;
    Edit4.Enabled := True;
    ComboBox2.Enabled := False;
    ComboBox3.Enabled := False;
    ComboBox4.Enabled := False;
    ComboBox5.Enabled := False;
    end;
  end;
  Model();
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0:begin
    Edit1.Enabled := False;
    Edit2.Enabled := False;
    ComboBox2.Enabled := True;
    ComboBox3.Enabled := True;
    end;
  1:begin
    Edit1.Enabled := False;
    Edit2.Enabled := False;
    Edit3.Enabled := False;
    ComboBox2.Enabled := True;
    ComboBox3.Enabled := True;
    ComboBox4.Enabled := True;
    end;
  2:begin
    Edit1.Enabled := False;
    Edit2.Enabled := False;
    Edit3.Enabled := False;
    Edit4.Enabled := False;
    ComboBox2.Enabled := True;
    ComboBox3.Enabled := True;
    ComboBox4.Enabled := True;
    ComboBox5.Enabled := True;
    end;
  end;
  Model();
end;

procedure TForm1.strelka(x1, y1, x2, y2: integer; s_deg:real; col: TColor);
var
  s_rad : Real;
  mid_x, mid_y : integer;
begin

  s_rad := s_deg * pi / 180;
  mid_x := x2 + ((x1 - x2) div 2);
  mid_y := y1 + ((y2 - y1) div 2);

  Image1.Canvas.Pen.Color := col;
  Image1.Canvas.Pen.Width := 2;

  Image1.Canvas.MoveTo(mid_x, mid_y);
  Image1.Canvas.LineTo(mid_x - Round(strelk * Cos( s_rad + (15 * pi / 180))), mid_y + Round(strelk * Sin (s_rad + (15 * pi / 180))));
  Image1.Canvas.MoveTo(mid_x, mid_y);
  Image1.Canvas.LineTo(mid_x - Round(strelk * Cos( s_rad - (15 * pi / 180))), mid_y + Round(strelk * Sin (s_rad - (15 * pi / 180))));
end;

procedure TForm1.chk_color(x: real; cl1: TColor; var _RGB: TColor);
begin
  if cl1 = clRed then
    _RGB := RGB(255,Round(255*(1-x)),Round(255*(1-x)))
  else
  if cl1 = clBlue then
    _RGB := RGB(Round(255*(1-x)),Round(255*(1-x)),255)
  else
  if cl1 = clGreen then
    _RGB := RGB(Round(255*(1-x)),255,Round(255*(1-x)))
  else
    _RGB := RGB(255,255,Round(255*(1-x)));

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Model();
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
  case Key of
    13 : Model();
  end;
end;

end.
