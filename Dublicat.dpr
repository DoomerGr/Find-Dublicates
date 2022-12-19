program Dublicat;

uses
  Vcl.Forms,
  Fm_Dublicat in 'Fm_Dublicat.pas' {FmDublicat},
  DiskTools in 'DiskTools.pas',
  Vcl.Themes,
  Vcl.Styles,
  WinEdit in 'WinEdit.pas' {FmWinEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TFmDublicat, FmDublicat);
  Application.CreateForm(TFmWinEdit, FmWinEdit);
  Application.Run;
end.
