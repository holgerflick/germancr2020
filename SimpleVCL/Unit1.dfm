object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 406
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    692
    406)
  PixelsPerInch = 96
  TextHeight = 13
  object Map: TTMSFNCMaps
    Left = 8
    Top = 48
    Width = 665
    Height = 350
    ParentDoubleBuffered = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = True
    TabOrder = 0
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    Options.DefaultLatitude = 40.689247000000000000
    Options.DefaultLongitude = -74.044501999999990000
  end
  object btnGoogle: TButton
    Left = 16
    Top = 16
    Width = 113
    Height = 25
    Caption = 'Google'
    TabOrder = 1
    OnClick = btnGoogleClick
  end
  object btnLayers: TButton
    Left = 135
    Top = 17
    Width = 113
    Height = 25
    Caption = 'Open Layers'
    TabOrder = 2
    OnClick = btnLayersClick
  end
end
