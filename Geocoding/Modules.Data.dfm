object DBController: TDBController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 224
  Width = 385
  object Connection: TFDConnection
    Params.Strings = (
      'ConnectionDef=covid_usa')
    FetchOptions.AssignedValues = [evRecordCountMode]
    FetchOptions.RecordCountMode = cmTotal
    ConnectedStoredUsage = []
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 48
  end
  object QuCoordinates: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT * FROM coordinates')
    Left = 80
    Top = 144
  end
  object QuCounties: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'SELECT State, County FROM counties GROUP BY State, County')
    Left = 224
    Top = 136
  end
end
