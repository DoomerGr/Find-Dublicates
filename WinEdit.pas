unit WinEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, RzPanel,
  Vcl.StdCtrls, Vcl.ComCtrls, RzEdit, System.ImageList, Vcl.ImgList,
  Vcl.ShellAnimations, System.Actions, Vcl.ActnList;

type
  TFmWinEdit = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mnSaveAs: TMenuItem;
    N3: TMenuItem;
    mnClose: TMenuItem;
    RzPanel1: TRzPanel;
    RzRichEditEchoWin: TRzRichEdit;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    PopupMenuEcho: TPopupMenu;
    PopUndo: TMenuItem;
    MenuItem1: TMenuItem;
    PopCut: TMenuItem;
    PopCopy: TMenuItem;
    PopPast: TMenuItem;
    N6: TMenuItem;
    PopClearAll: TMenuItem;
    PopSelectAll: TMenuItem;
    N5: TMenuItem;
    e1: TMenuItem;
    N7: TMenuItem;
    popOpenFile: TMenuItem;
    popFoundFile: TMenuItem;
    N9: TMenuItem;
    ShellResources1: TShellResources;
    mnOpen: TMenuItem;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    ActionOpen: TAction;
    ActionSaveAs: TAction;
    ActionClose: TAction;
    StatusBar1: TStatusBar;
    procedure PopupMenuEchoPopup(Sender: TObject);
    procedure PopUndoClick(Sender: TObject);
    procedure PopCopyClick(Sender: TObject);
    procedure PopCutClick(Sender: TObject);
    procedure PopPastClick(Sender: TObject);
    procedure PopSelectAllClick(Sender: TObject);
    procedure PopClearAllClick(Sender: TObject);
    procedure e1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure popOpenFileClick(Sender: TObject);
    procedure popFoundFileClick(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmWinEdit: TFmWinEdit;

implementation

{$R *.dfm}

uses vcl.Clipbrd,ShellApi;

procedure TFmWinEdit.PopupMenuEchoPopup(Sender: TObject);
var re : TRzRichEdit;
begin
  re:=RzRichEditEchoWin;
  PopUndo.Enabled := re.CanUndo;
  PopCut.Enabled := re.SelText <> '';
  PopCopy.Enabled := re.SelText <> '';
  PopClearAll.Enabled := re.SelText <> '';
  PopPast.Enabled := Clipboard.HasFormat(CF_TEXT) ;
end;

procedure TFmWinEdit.PopUndoClick(Sender: TObject);
begin
  RzRichEditEchoWin.Undo
end;

procedure TFmWinEdit.PopCutClick(Sender: TObject);
begin
  RzRichEditEchoWin.CutToClipboard
end;

procedure TFmWinEdit.PopCopyClick(Sender: TObject);
begin
   RzRichEditEchoWin.CopyToClipboard
end;

procedure TFmWinEdit.PopPastClick(Sender: TObject);
begin
   RzRichEditEchoWin.PasteFromClipboard
end;

procedure TFmWinEdit.PopClearAllClick(Sender: TObject);
begin
 RzRichEditEchoWin.Clear
end;

procedure TFmWinEdit.PopSelectAllClick(Sender: TObject);
begin
 RzRichEditEchoWin.SelectAll;
end;



procedure TFmWinEdit.e1Click(Sender: TObject);
begin
 RzRichEditEchoWin.SelectAll;
 RzRichEditEchoWin.SelAttributes.Size:=FmWinEdit.RzRichEditEchoWin.SelAttributes.Size-1;
 RzRichEditEchoWin.SelStart:=0;
end;

procedure TFmWinEdit.N7Click(Sender: TObject);
begin
 RzRichEditEchoWin.SelectAll;
 RzRichEditEchoWin.SelAttributes.Size:=FmWinEdit.RzRichEditEchoWin.SelAttributes.Size+1;
 RzRichEditEchoWin.SelStart:=0;
end;

procedure TFmWinEdit.popOpenFileClick(Sender: TObject);
var st,NameF:String;

begin
 st:=RzRichEditEchoWin.Lines[RzRichEditEchoWin.CaretPos.Y];
 namef:=copy(st,pos('Папка:',st)+7,Length(st))+copy(st,7,pos(' <=>',st)-7);
 if FileExists(namef) then
   shellExecute(Handle,'open', PChar(namef), nil, nil, SW_SHOWNORMAL);
end;


procedure TFmWinEdit.popFoundFileClick(Sender: TObject);
var st,NamePath:String;
begin
 st:=RzRichEditEchoWin.Lines[RzRichEditEchoWin.CaretPos.Y];
 namepath:=copy(st,pos('Папка:',st)+7,Length(st));
 if DirectoryExists(namepath) then
   ShellExecute(Handle, 'open',PChar(namepath), nil, nil,SW_SHOWNORMAL);
end;


procedure TFmWinEdit.ActionOpenExecute(Sender: TObject);
begin
 if OpenDialog1.Execute then RzRichEditEchoWin.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TFmWinEdit.ActionCloseExecute(Sender: TObject);
begin
 FmWinEdit.close;
end;

procedure TFmWinEdit.ActionSaveAsExecute(Sender: TObject);
begin
 if SaveDialog1.Execute then RzRichEditEchoWin.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
