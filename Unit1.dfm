object Form1: TForm1
  Left = 0
  Top = 0
  VertScrollBar.Tracking = True
  BorderIcons = [biSystemMenu]
  Caption = 
    'Fotka v.2.1 - wycinanie zdj'#281'c 1355x1650 pikseli max.100KB  -   C' +
    'opyright (c) 2014-2025 M@rcin GPL-2.0 license'
  ClientHeight = 741
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000000000000000000000000000000000000000000000000
    0000000000000000000200000002000000000000000000000001000000050000
    0006000000060000000600000006000000060000000300000001000000000000
    000000000003000000550000005500000004000000010000003A000000960000
    009E0000009E0000009E0000009E0000009E0000008700000017000000000000
    000200000054000000CB000000CB000000540000000C000000AC000000200000
    0011000000110000001100000011000000120000004600000086000000030000
    000100000031000000630000006300000032000000120000009E000000060000
    000100000000000000000000000000000001000000120000009D000000060000
    0000000000020000005D0000005D00000003000000110000009E000000060000
    000000000000000000000000000000000000000000110000009E000000060000
    0000000000010000005D0000005D00000002000000110000009E000000060000
    000000000000000000000000000000000000000000110000009E000000060000
    0000000000010000005D0000005D00000002000000110000009E000000060000
    000000000000000000000000000000000000000000110000009E000000060000
    0000000000010000005D0000005D00000002000000110000009E000000060000
    000000000000000000000000000000000001000000110000009E000000060000
    0000000000010000005D0000005D000000020000000D000000A50000000C0000
    0006000000060000000600000006000000060000002100000095000000050000
    0000000000010000005D0000005D000000010000000300000072000000A60000
    009E0000009E0000009E0000009E0000009E000000AE00000039000000000000
    0000000000010000005B0000005B0000000100000000000000040000000E0000
    0011000000110000001100000011000000120000000D00000002000000000000
    0000000000000000001B0000001B000000010000000200000001000000020000
    0002000000020000000200000003000000300000005400000004000000000000
    00000000000000000001000000010000001B0000005D0000005D0000005D0000
    005D0000005D0000005D0000005D00000062000000CD00000055000000020000
    00000000000000000000000000010000001B0000005D0000005D0000005D0000
    005D0000005D0000005D0000005D00000062000000CD00000055000000020000
    0000000000000000000000000000000000000000000200000001000000010000
    00010000000100000001000000020000002F0000005400000004000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000001000000020000000000000000CC01
    000080010000000000000070000080F8000080F8000080F8000080F000008000
    00008001000084010000C0010000C0000000E0000000F8010000FFF30000}
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 108
    Height = 25
    Caption = 'Z'#322'ap ramk'#281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image2: TImage
    Left = 0
    Top = 0
    Width = 600
    Height = 600
  end
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 217
    Height = 281
    Enabled = False
    Stretch = True
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Label2: TLabel
    Left = 768
    Top = 200
    Width = 32
    Height = 13
    Caption = 'Label2'
    Visible = False
  end
  object Label3: TLabel
    Left = 840
    Top = 224
    Width = 32
    Height = 13
    Caption = 'Label3'
    Visible = False
  end
  object Label4: TLabel
    Left = 704
    Top = 216
    Width = 32
    Height = 13
    Caption = 'Label4'
    Visible = False
  end
  object Label5: TLabel
    Left = 792
    Top = 224
    Width = 32
    Height = 13
    Caption = 'Label5'
    Visible = False
  end
  object Label6: TLabel
    Left = 744
    Top = 248
    Width = 32
    Height = 13
    Caption = 'Label6'
    Visible = False
  end
  object Label7: TLabel
    Left = 840
    Top = 312
    Width = 32
    Height = 13
    Caption = 'Label7'
    Visible = False
  end
  object Button1: TButton
    Left = 768
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Otw'#243'rz'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 840
    Top = 678
    Width = 75
    Height = 25
    Caption = 'Zamknij'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button4Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 709
    Width = 924
    Height = 32
    Panels = <
      item
        Width = 50
      end>
    ExplicitTop = 701
    ExplicitWidth = 922
  end
  object Button5: TButton
    Left = 824
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Drukuj'
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = Button5Click
  end
  object Button2: TButton
    Left = 768
    Top = 97
    Width = 131
    Height = 25
    Caption = 'Wytnij i Zamknij'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 728
    Top = 264
    Width = 75
    Height = 25
    Caption = '640x480'
    TabOrder = 5
    Visible = False
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 769
    Top = 57
    Width = 147
    Height = 17
    Caption = 'Dodaj dat'#281' na zdj'#281'ciu'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 6
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'All|*.jpg;*.jpeg|JPEG Image File (*.jpg)|*.jpg|JPEG Image File (' +
      '*.jpeg)|*.jpeg'
    Left = 808
    Top = 400
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 
      'All (*.jpg;*.jpeg)|*.jpg;*.jpeg;|JPEG Image File (*.jpg)|*.jpg|J' +
      'PEG Image File (*.jpeg)|*.jpeg'
    Left = 800
    Top = 328
  end
end
