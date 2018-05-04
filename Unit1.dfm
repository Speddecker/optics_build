object Form1: TForm1
  Left = 181
  Top = 184
  Width = 985
  Height = 532
  Caption = #1054#1087#1090#1080#1082#1072' - '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1077' '#1083#1091#1095#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 545
    Top = 0
    Width = 432
    Height = 498
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 545
    Height = 498
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 88
      Width = 114
      Height = 13
      Caption = #1057#1088#1077#1076#1072' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' 1.'
    end
    object Label2: TLabel
      Left = 8
      Top = 112
      Width = 111
      Height = 13
      Caption = #1057#1088#1077#1076#1072' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' 2'
    end
    object Label3: TLabel
      Left = 8
      Top = 192
      Width = 95
      Height = 13
      Caption = #1059#1075#1086#1083' '#1087#1072#1076#1077#1085#1080#1103' '#1083#1091#1095#1072
    end
    object Label4: TLabel
      Left = 368
      Top = 56
      Width = 121
      Height = 13
      Caption = #1059#1075#1086#1083' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' '#1083#1091#1095#1072
    end
    object Label5: TLabel
      Left = 8
      Top = 8
      Width = 118
      Height = 13
      Caption = #1056#1077#1078#1080#1084' '#1084#1086#1076#1077#1083#1080#1088#1086#1074#1072#1085#1080#1103
    end
    object Label6: TLabel
      Left = 152
      Top = 40
      Width = 168
      Height = 13
      Caption = #1050#1086#1086#1092#1080#1094#1080#1077#1085#1090#1099' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' '#1089#1088#1077#1076
    end
    object Label7: TLabel
      Left = 8
      Top = 136
      Width = 111
      Height = 13
      Caption = #1057#1088#1077#1076#1072' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' 3'
      Visible = False
    end
    object Label8: TLabel
      Left = 8
      Top = 156
      Width = 111
      Height = 13
      Caption = #1057#1088#1077#1076#1072' '#1087#1088#1077#1083#1086#1084#1083#1077#1085#1080#1103' 4'
      Visible = False
    end
    object Label9: TLabel
      Left = 176
      Top = 192
      Width = 24
      Height = 13
      Caption = #1043#1088#1072#1076
    end
    object Label10: TLabel
      Left = 496
      Top = 90
      Width = 24
      Height = 13
      Caption = #1043#1088#1072#1076
    end
    object Label11: TLabel
      Left = 496
      Top = 111
      Width = 24
      Height = 13
      Caption = #1043#1088#1072#1076
    end
    object Label12: TLabel
      Left = 496
      Top = 132
      Width = 24
      Height = 13
      Caption = #1043#1088#1072#1076
      Visible = False
    end
    object Edit1: TEdit
      Left = 136
      Top = 80
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '1'
      OnKeyDown = Edit1KeyDown
    end
    object Edit2: TEdit
      Left = 136
      Top = 104
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 1
      Text = '1'
      OnKeyDown = Edit1KeyDown
    end
    object Edit3: TEdit
      Left = 136
      Top = 128
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = '1'
      Visible = False
      OnKeyDown = Edit1KeyDown
    end
    object Edit4: TEdit
      Left = 136
      Top = 152
      Width = 57
      Height = 21
      Enabled = False
      TabOrder = 3
      Text = '1'
      Visible = False
      OnKeyDown = Edit1KeyDown
    end
    object ComboBox1: TComboBox
      Left = 136
      Top = 8
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = '2 '#1089#1088#1077#1076#1099
      OnChange = ComboBox1Change
      Items.Strings = (
        '2 '#1089#1088#1077#1076#1099
        '3 '#1089#1088#1077#1076#1099
        '4 '#1089#1088#1077#1076#1099)
    end
    object RadioButton1: TRadioButton
      Left = 136
      Top = 56
      Width = 57
      Height = 17
      Caption = #1057#1074#1086#1080
      TabOrder = 5
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 208
      Top = 56
      Width = 145
      Height = 17
      Caption = #1042#1099#1073#1086#1088#1086#1095#1085#1099#1077
      Checked = True
      TabOrder = 6
      TabStop = True
      OnClick = RadioButton2Click
    end
    object ComboBox2: TComboBox
      Left = 208
      Top = 80
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 7
      Text = #1042#1072#1082#1091#1091#1084
      OnChange = ComboBox1Change
      Items.Strings = (
        #1042#1072#1082#1091#1091#1084
        #1042#1086#1076#1072' '#1076#1080#1089#1090#1080#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
        #1041#1077#1085#1079#1086#1083
        #1043#1083#1080#1094#1077#1088#1080#1085
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1077#1088#1085#1072#1103
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1086#1083#1103#1085#1072#1103
        #1057#1087#1080#1088#1090' '#1069#1090#1080#1083#1086#1074#1099#1081
        #1052#1072#1089#1083#1086' '#1087#1086#1076#1089#1086#1083#1085#1077#1095#1085#1086#1077
        #1040#1083#1084#1072#1079
        #1057#1090#1077#1082#1083#1086)
    end
    object ComboBox3: TComboBox
      Left = 208
      Top = 104
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 8
      Text = #1042#1072#1082#1091#1091#1084
      OnChange = ComboBox1Change
      Items.Strings = (
        #1042#1072#1082#1091#1091#1084
        #1042#1086#1076#1072' '#1076#1080#1089#1090#1080#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
        #1041#1077#1085#1079#1086#1083
        #1043#1083#1080#1094#1077#1088#1080#1085
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1077#1088#1085#1072#1103
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1086#1083#1103#1085#1072#1103
        #1057#1087#1080#1088#1090' '#1069#1090#1080#1083#1086#1074#1099#1081
        #1052#1072#1089#1083#1086' '#1087#1086#1076#1089#1086#1083#1085#1077#1095#1085#1086#1077
        #1040#1083#1084#1072#1079
        #1057#1090#1077#1082#1083#1086)
    end
    object ComboBox4: TComboBox
      Left = 208
      Top = 128
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 9
      Text = #1042#1072#1082#1091#1091#1084
      Visible = False
      OnChange = ComboBox1Change
      Items.Strings = (
        #1042#1072#1082#1091#1091#1084
        #1042#1086#1076#1072' '#1076#1080#1089#1090#1080#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
        #1041#1077#1085#1079#1086#1083
        #1043#1083#1080#1094#1077#1088#1080#1085
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1077#1088#1085#1072#1103
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1086#1083#1103#1085#1072#1103
        #1057#1087#1080#1088#1090' '#1069#1090#1080#1083#1086#1074#1099#1081
        #1052#1072#1089#1083#1086' '#1087#1086#1076#1089#1086#1083#1085#1077#1095#1085#1086#1077
        #1040#1083#1084#1072#1079
        #1057#1090#1077#1082#1083#1086)
    end
    object ComboBox5: TComboBox
      Left = 208
      Top = 152
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 10
      Text = #1042#1072#1082#1091#1091#1084
      Visible = False
      OnChange = ComboBox1Change
      Items.Strings = (
        #1042#1072#1082#1091#1091#1084
        #1042#1086#1076#1072' '#1076#1080#1089#1090#1080#1083#1080#1088#1086#1074#1072#1085#1085#1072#1103
        #1041#1077#1085#1079#1086#1083
        #1043#1083#1080#1094#1077#1088#1080#1085
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1077#1088#1085#1072#1103
        #1050#1080#1089#1083#1086#1090#1072' '#1089#1086#1083#1103#1085#1072#1103
        #1057#1087#1080#1088#1090' '#1069#1090#1080#1083#1086#1074#1099#1081
        #1052#1072#1089#1083#1086' '#1087#1086#1076#1089#1086#1083#1085#1077#1095#1085#1086#1077
        #1040#1083#1084#1072#1079
        #1057#1090#1077#1082#1083#1086)
    end
    object Edit5: TEdit
      Left = 368
      Top = 90
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 11
      Text = '0'
    end
    object Edit6: TEdit
      Left = 368
      Top = 111
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 12
      Text = '0'
      Visible = False
    end
    object Edit7: TEdit
      Left = 368
      Top = 132
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 13
      Text = '0'
      Visible = False
    end
    object Edit9: TEdit
      Left = 112
      Top = 192
      Width = 57
      Height = 21
      TabOrder = 14
      Text = '0'
      OnKeyDown = Edit1KeyDown
    end
    object Button1: TButton
      Left = 136
      Top = 264
      Width = 121
      Height = 49
      Caption = #1052#1086#1076#1077#1083#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 15
      Visible = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 264
      Width = 121
      Height = 49
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 16
      OnClick = Button2Click
    end
    object TrackBar1: TTrackBar
      Left = 24
      Top = 216
      Width = 489
      Height = 45
      Max = 90
      TabOrder = 17
      OnChange = TrackBar1Change
    end
    object CheckBox1: TCheckBox
      Left = 288
      Top = 8
      Width = 185
      Height = 17
      Caption = #1042' '#1090'.'#1095'. '#1089' '#1085#1077#1087#1086#1083#1085#1099#1084' '#1086#1090#1088#1072#1078#1077#1085#1080#1077#1084
      TabOrder = 18
      OnClick = CheckBox1Click
    end
  end
end
