object frmDM: TfrmDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 281
  Width = 440
  object Con: TFDConnection
    Params.Strings = (
      'Database=dbtestewk'
      'User_Name=root'
      'Password=up1*6658478'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 216
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\01 - Desenvolvimento\WkTechnology\Win32\Debug\libmysql.dll'
    Left = 104
    Top = 216
  end
end
