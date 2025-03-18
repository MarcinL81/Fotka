unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ExtDlgs, ComCtrls, printers;

type
  TForm1 = class(TForm)

    Button1: TButton;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Button4: TButton;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Button5: TButton;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button3: TButton;
    CheckBox1: TCheckBox;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    { Private declarations }
    Drawing: boolean;

  public
    procedure DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
    procedure ResizeBitmap2(Bitmap: TBitmap; Width, Height: Integer;
      Background: TColor);
    procedure PrintImage(Image: TImage; ZoomPercent: Integer);
    procedure CropBitmap(InBitmap, OutBitMap: TBitmap; X, Y, W, H: Integer);
    { Public declarations }
  end;

var
  C: TBitmap;
  Form1: TForm1;
  LMButton: boolean;
  tmp: boolean;
  Mouse: TPoint;
  ZoomBmp: TBitmap;
  mnoznik, HH, WW: Integer;
  Bmpo: TBitmap;
  kompresja: Integer;
  jpg2: TJPEGImage;

implementation

uses Math;

{$R *.dfm}

function CheckFileSize(FileName: String): Integer;
var
  Plik: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, Plik) = 0 then
    Result := Plik.Size
  else
    Result := -1;
  FindClose(Plik);
end;

procedure TForm1.CropBitmap(InBitmap, OutBitMap: TBitmap; X, Y, W, H: Integer);
begin
  OutBitMap.PixelFormat := InBitmap.PixelFormat;
  OutBitMap.Width := W;
  OutBitMap.Height := H;
  BitBlt(OutBitMap.Canvas.Handle, 0, 0, W, H, InBitmap.Canvas.Handle, X,
    Y, SRCCOPY);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ex: String;
  jpg: TJPEGImage;
  bmp: TBitmap;
  jpgf: TJPEGImage;
  bmpf: TBitmap;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Enabled := True;
    ex := UpperCase(ExtractFileExt(OpenPictureDialog1.FileName));
    if (ex = '.JPG') or (ex = '.JPEG') then
    begin
      jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      Bmpo := TBitmap.Create;
      jpg.LoadFromFile(OpenPictureDialog1.FileName);

      if (jpg.Height > 1650) and (jpg.Width > 1355) then
      begin
        Button2.Enabled := True;
        Image1.Visible:=true;
      Image2.Visible:=true;
        mnoznik := 1;
        mnoznik := round(jpg.Height / 600);
        Label2.Caption := inttostr(jpg.Width) + ' ' + inttostr(jpg.Height) + ' '
          + floatToStr((jpg.Width * jpg.Height) / 1000000);
        Label3.Caption := inttostr(round((jpg.Width * jpg.Height)));
        Label4.Caption := inttostr(mnoznik);
        bmp.Assign(jpg);
        Bmpo.Assign(jpg);
        Image2.Picture.Bitmap.Assign(bmp);
        StatusBar1.Panels[0].Text := 'Zdjêcie posiada poprawn¹ rozdzielczoœæ ' +
          inttostr(jpg.Width) + 'x' + inttostr(jpg.Height) +
          ' pikseli. Z³ap ramkê i wykadruj zdjêcie do wyciêcia.';
        StatusBar1.Color := clGreen;
        jpg.Free;
        bmp.Free;

        Image1.Width := round(1355 / mnoznik);
        Image1.Height := round(1650 / mnoznik);
        jpgf := TJPEGImage.Create;
        bmpf := TBitmap.Create;
        jpgf.LoadFromFile(OpenPictureDialog1.FileName);
        bmpf.Assign(jpgf);
        Image2.Width := round(jpgf.Width / mnoznik);
        Image2.Height := round(jpgf.Height / mnoznik);
        ResizeBitmap2(bmpf, round(jpgf.Width / mnoznik),
          round(jpgf.Height / mnoznik), clred);

        Image2.Picture.Bitmap.Assign(bmpf);

        jpgf.Free;
        bmpf.Free;
        WW := Image2.Width;
        HH := Image2.Height;

      end
      else
      begin
      Image1.Visible:=false;
      Image2.Visible:=false;
        Button2.Enabled := false;
        StatusBar1.Panels[0].Text := 'Zdjêcie posiada za nisk¹ rozdzielczoœæ ' +
          inttostr(jpg.Width) + 'x' + inttostr(jpg.Height) +
          ' pikseli min. to 1355x1650 pikseli w aparacie ustaw 3Mpx lub wiêcej.';
             StatusBar1.Color := clRed;
      end;
    end;

  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Drawing := false;
  kompresja := 0;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LMButton := True;
  tmp := True;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LMButton := false;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

begin

  if (LMButton) then
  begin
    if (tmp) then
    begin
      Mouse.X := X;
      Mouse.Y := Y;
    end;
    tmp := false;

    Image1.Left := Image1.Left + X - Mouse.X;
    Image1.Top := Image1.Top + Y - Mouse.Y;
  end;

  if OpenPictureDialog1.FileName <> '' then
  begin
    C := TBitmap.Create;
    C.Width := round(1355 / mnoznik);
    C.Height := round(1650 / mnoznik);

    Form1.Refresh;
    C.Canvas.CopyRect(Rect(0, 0, round(1355 / mnoznik), round(1650 / mnoznik)),
      Image2.Canvas, Rect(Image1.Left, Image1.Top,
      Image1.Left + round(1355 / mnoznik), Image1.Top + round(1650 / mnoznik)));
    Form1.Canvas.Rectangle(Image1.Left + round(1355 / mnoznik) + 4,
      Image1.Top + round(1650 / mnoznik) + 4, Image1.Left - 4, Image1.Top - 4);
    Form1.Canvas.MoveTo(Image1.Left, Image1.Top + round((1650 / mnoznik) / 2));
    Form1.Canvas.LineTo(Image1.Left + round(1355 / mnoznik) + 1,
      Image1.Top + round((1650 / mnoznik) / 2));

    Image1.Canvas.Draw(0, 0, C);

    C.Free;

    // Button2.Click;

  end;
  Button5.Enabled := True;

end;

procedure TForm1.PrintImage(Image: TImage; ZoomPercent: Integer);
// if ZoomPercent=100, Image will be printed across the whole page
var
  relHeight, relWidth: Integer;
begin
  Screen.Cursor := crHourglass;
  Printer.BeginDoc;
  with Image.Picture.Bitmap do
  begin
    if ((Width / Height) > (Printer.PageWidth / Printer.PageHeight)) then
    begin
      // Stretch Bitmap to width of PrinterPage
      relWidth := Printer.PageWidth;
      relHeight := MulDiv(Height, Printer.PageWidth, Width);
    end
    else
    begin
      // Stretch Bitmap to height of PrinterPage
      relWidth := MulDiv(Width, Printer.PageHeight, Height);
      relHeight := Printer.PageHeight;
    end;
    relWidth := round(relWidth * ZoomPercent / 100);
    relHeight := round(relHeight * ZoomPercent / 100);
    DrawImage(Printer.Canvas, Rect(0, 0, relWidth, relHeight),
      Image.Picture.Bitmap);
  end;
  Printer.EndDoc;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  PrintImage(Image1, 20);
end;

procedure TForm1.DrawImage(Canvas: TCanvas; DestRect: TRect; ABitmap: TBitmap);
var
  Header, Bits: Pointer;
  HeaderSize: DWORD;
  BitsSize: DWORD;
begin
  GetDIBSizes(ABitmap.Handle, HeaderSize, BitsSize);
  Header := AllocMem(HeaderSize);
  Bits := AllocMem(BitsSize);
  try
    GetDIB(ABitmap.Handle, ABitmap.Palette, Header^, Bits^);
    StretchDIBits(Canvas.Handle, DestRect.Left, DestRect.Top, DestRect.Right,
      DestRect.Bottom, 0, 0, ABitmap.Width, ABitmap.Height, Bits,
      TBitmapInfo(Header^), DIB_RGB_COLORS, SRCCOPY);
  finally
    FreeMem(Header, HeaderSize);
    FreeMem(Bits, BitsSize);
  end;
end;

procedure TForm1.ResizeBitmap2(Bitmap: TBitmap; Width, Height: Integer;
  Background: TColor);
var
  R: TRect;
  B: TBitmap;
  X, Y: Integer;
begin
  if assigned(Bitmap) then
  begin
    B := TBitmap.Create;
    try
      if Bitmap.Width > Bitmap.Height then
      begin
        R.Right := Width;
        R.Bottom := ((Width * Bitmap.Height) div Bitmap.Width);
        X := 0;
        Y := (Height div 2) - (R.Bottom div 2);
      end
      else
      begin
        R.Right := ((Height * Bitmap.Width) div Bitmap.Height);
        R.Bottom := Height;
        X := (Width div 2) - (R.Right div 2);
        Y := 0;
      end;
      R.Left := 0;
      R.Top := 0;
      B.PixelFormat := Bitmap.PixelFormat;
      B.Width := Width;
      B.Height := Height;
      B.Canvas.Brush.Color := Background;
      B.Canvas.FillRect(B.Canvas.ClipRect);
      B.Canvas.StretchDraw(R, Bitmap);
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Bitmap.Canvas.Brush.Color := Background;
      Bitmap.Canvas.FillRect(Bitmap.Canvas.ClipRect);
      Bitmap.Canvas.Draw(X, Y, B);
    finally
      B.Free;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  jpg2, jpeg: TJPEGImage; // deklaracja nowej zmiennej
  Bmpk: TBitmap;
  AStream: TStream;
  ii: Integer;
begin

  jpg2 := TJPEGImage.Create;

  Bmpk := TBitmap.Create;

  AStream := TMemoryStream.Create;
  jpeg := TJPEGImage.Create;

  CropBitmap(Bmpo, Bmpk, Image1.Left * mnoznik, Image1.Top * mnoznik,
    1355, 1650);
  if CheckBox1.Checked = True then
  begin
    Bmpk.Canvas.Font.Size := 50;
    Bmpk.Canvas.Brush.Style := bsClear;
    Bmpk.Canvas.Font.Style := [fsBold];
    Bmpk.Canvas.Font.Color := clred;
    Bmpk.Canvas.TextOut(900, 1550, DateToStr(Now));
  end;
  jpg2.Assign(Bmpk);
  jpg2.CompressionQuality := 100;
  jpg2.Compress;

  // jpg2.SaveToFile(ChangeFileext(OpenPictureDialog1.filename, '_1355x1650.JPG'));
  // Label2.Caption := inttostr(CheckFileSize(ChangeFileext(OpenPictureDialog1.filename, '_1355x1650.JPG')));

  // Label3.Caption:= FloatToStr(Round((StrToInt(Label2.Caption))/1024));

  jpeg.Assign(jpg2);
  jpeg.SaveToStream(AStream);
  Label5.Caption := floatToStr(AStream.Size);

  for ii := 1 to 20 do
  begin
    AStream.Size := 0;
    // ii:=ii-10;
    jpg2.CompressionQuality := jpg2.CompressionQuality - 5;
    jpg2.Compress;
    jpeg.Assign(jpg2);

    jpg2.SaveToStream(AStream);
    Label6.Caption := floatToStr(AStream.Size) + ' ' +
      floatToStr(round((AStream.Size) / 1024));

    if AStream.Size <= 100000 then
    begin
      jpeg.SaveToFile(ChangeFileext(OpenPictureDialog1.FileName,
        '_CBDOPW.jpg'));
      Label7.Caption := inttostr(jpg2.CompressionQuality);
      break;
    end;
  end;

  AStream.Free;
  Bmpk.Free;
  jpg2.Free;
  jpeg.Free;
         close;
end;

procedure TForm1.Button3Click(Sender: TObject);
{ var
  jpg  : TJpegImage;
  bmp : TBitmap ; }
begin
  {
    jpg := TJPEGImage.Create; bmp := TBitmap.Create;
    jpg.LoadFromFile(OpenPictureDialog1.FileName);
    bmp.Assign(jpg);

    ResizeBitmap2(bmp,640,480,clred);

    image2.Picture.Bitmap.Assign(bmp);
    jpg.Free; bmp.Free;
    Image2.Width:= 640;
    Image2.Height:=480;
  }

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Close;
end;

end.
