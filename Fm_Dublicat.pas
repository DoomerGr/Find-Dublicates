unit Fm_Dublicat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,ShellApi,
  RzPanel, RzBorder, Vcl.ComCtrls, Vcl.Buttons, RzSpnEdt, RzLabel, Vcl.DBCtrls,
  Winapi.ShlObj,DiskTools,Winapi.RichEdit,RzEdit, Vcl.Mask, Vcl.Menus, RzStatus,
  Vcl.WinXCtrls, RzButton;

const DUBLTHREAD_TERMINATED=WM_USER+1;


type

  TConfig = record
  B_Name,B_Date,B_Size,
  InFolder,R_CRC:boolean;
  SizeLimit:int64;
  Master:TForm;
  MAction:string[5];
  DestPath:String;
  ListFilter:TStringList;
  mode:byte;
  procedure Init(Master:TForm);
 end;


 TListBox = class(Vcl.StdCtrls.TListBox)
 private
   procedure WMDROPFILES(var Msg: TMessage); message WM_DROPFILES;
 public
 end;

 TEdit = class(Vcl.StdCtrls.TEdit)
 private
   procedure WMDROPFILES(var Msg: TMessage); message WM_DROPFILES;
 public
 end;

  TFmDublicat = class(TForm)
    Panel1: TPanel;
    ListBoxListPath: TListBox;
    RzPanel1: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    CheckBoxName: TCheckBox;
    CheckBoxData: TCheckBox;
    CheckBoxCRC: TCheckBox;
    RzGroupBoxModeCompare: TRzGroupBox;
    RadioButtonMove: TRadioButton;
    RadioButtonCopy: TRadioButton;
    RadioButtonDelete: TRadioButton;
    RzPanelEditEcho: TRzPanel;
    RzRichEditEchoCom: TRzRichEdit;
    RzGroupBox3: TRzGroupBox;
    CheckBoxInFolder: TCheckBox;
    RzEditFilter: TRzEdit;
    RzLabel1: TRzLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    RzPanelDistPath: TRzPanel;
    EditDistPath: TEdit;
    RzLabel4: TRzLabel;
    RzPanelProgress: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabelNameFile: TRzLabel;
    ProgressBarFile: TProgressBar;
    RzBtnStopCopy: TRzRapidFireButton;
    ButtonRun: TButton;
    ButtonClose: TButton;
    ProgressBarAll: TProgressBar;
    RzLabel3: TRzLabel;
    PopupMenuEcho: TPopupMenu;
    PopUndo: TMenuItem;
    N2: TMenuItem;
    PopCut: TMenuItem;
    PopCopy: TMenuItem;
    PopPast: TMenuItem;
    N6: TMenuItem;
    PopSelectAll: TMenuItem;
    Timer1: TTimer;
    RadioButtonAnaliz: TRadioButton;
    RzVersionInfo1: TRzVersionInfo;
    RzLabelVersion: TRzLabel;
    RzPanelProgressCreateList: TRzPanel;
    RzLabel5: TRzLabel;
    RzLblNameFileList: TRzLabel;
    RzButtonBreakCrList: TRzRapidFireButton;
    ProgressBar2: TProgressBar;
    CheckBoxCompSize: TCheckBox;
    ActivityIndicator1: TActivityIndicator;
    RzBorder1: TRzBorder;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzEditSizeLimit: TRzEdit;
    N3: TMenuItem;
    popWinEdit: TMenuItem;
    RzBitBtnStopCompare: TRzBitBtn;
    RzLabelBreak: TRzLabel;
    N5: TMenuItem;
    PopClearAll: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRunClick(Sender: TObject);
    procedure AddEchoText(Edit:TRzRichEdit;Str:String; Color: TColor;Tip:byte);
    procedure RzBtnStopCopyClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ListBoxListPathDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ListBoxListPathDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CopyFilesOfList(List:TStringList;PathTarget:String);
    procedure CopyFileExProgress(const AFrom,ATo:String);
    procedure PopupMenuEchoPopup(Sender: TObject);
    procedure PopUndoClick(Sender: TObject);
    procedure PopCutClick(Sender: TObject);
    procedure PopCopyClick(Sender: TObject);
    procedure PopPastClick(Sender: TObject);
    procedure PopClearAllClick(Sender: TObject);
    procedure PopSelectAllClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure popWinEditClick(Sender: TObject);
    procedure RzEditSizeLimitKeyPress(Sender: TObject; var Key: Char);
    procedure SpisokObjClear(List:TStringList);
    procedure RzBitBtnStopCompareClick(Sender: TObject);
    procedure ThreadTerminated(var Msg:TMessage); message DUBLTHREAD_TERMINATED;


  private
    FileCopier:IFileCopier;
    TaskBarList:ITaskBarList3;
    NZapisey,fProgress : integer;
    procedure setTaskProgress(newValue:integer;max:integer);
    procedure setTaskStopViewProg;

  public
   Stop:boolean;
   DublConf:TConfig;
   Ignor:Integer;
   Spisok:TStringList;
  end;

 TDublThread = class(System.Classes.TThread)
  public

  private
  MForm: TFmDublicat;
  NMsg,Mode:Byte;
  Path,FName:String;
  Stop:boolean;
  fEx : Exception;
  function  CreateLisForCompare(PathFolder:String;Spisok:TStringList):int64;
  procedure DublMsgPrint;
  procedure MSynchronize(_NMsg:byte;_FName:String;_Path:string);
  protected
  constructor Create; overload;
  procedure Execute; override;

end;

var
  FmDublicat: TFmDublicat;
  DublThread: TDublThread;

implementation

{$R *.dfm}

uses Vcl.FileCtrl,ComObj,vcl.Clipbrd, WinEdit;

function CreateListFilter(s:String):TStringList;
var tmp:string;
begin
 Result:=TStringList.Create;
 Result.Clear;
 while Length(S)<>0 do
  begin
    if Pos(';',S)<>0 then
      begin
       tmp:=copy(s,1,Pos(';',S)-1);
       delete(s,1,Pos(';',S));
       if pos('*',tmp)<>0 then
        begin
         Result.Add(copy(tmp,pos('*',tmp)-1,Length(tmp)-pos('*',tmp)+1));
        end
       else Result.Add(tmp)
      end
    else
    begin Result.Add(s);s:='';end;
  end;
end;


procedure TConfig.Init(Master:TForm);
begin
 with TFmDublicat(Master) do
  begin
   B_Name:=CheckBoxName.Checked;
   B_Date:=CheckBoxData.Checked;
   B_Size:=CheckBoxCompSize.Checked;
   InFolder:=CheckBoxInFolder.Checked;
   R_CRC:=CheckBoxCRC.Checked;
   if RzEditSizeLimit.Text<>'' then
    SizeLimit:=Trunc(StrToFloat(RzEditSizeLimit.Text)*1048576)
   else SizeLimit:=0;
   if RadioButtonMove.Checked then MAction:='move'
    else
     if RadioButtonCopy.Checked then MAction:='copy'
      else
       if RadioButtonDelete.Checked then MAction:='del';
   DestPath:=IncludeTrailingBackslash(EditDistPath.Text);
   if RzEditFilter.Text<>'' then ListFilter:=CreateListFilter(RzEditFilter.Text)
   else
    begin
     if ListFilter=nil then ListFilter:=TStringList.Create;
     ListFilter.Clear;ListFilter.Add('*.*');
   end;
   if (MAction='move') or (MAction='del') then mode:=1 else mode:=0;
  end;
end;


constructor TDublThread.Create;
begin
 inherited;
 FreeOnTerminate:=false;
 MForm:=FmDublicat;
 Priority:=tpLower;
 Mode:=1;
 Stop:=False;
end;


procedure TFmDublicat.SpisokObjClear(List:TStringList);
var i:integer;
begin
  if List<>nil then
   begin
    if List.Count>1 then
    for i:=0 to List.Count-1 do
    if List.Objects[i]<>nil then FreeAndNil(TAtribClass(List.Objects[i]));
    List.Clear
   end;
end;


procedure TFmDublicat.RzEditSizeLimitKeyPress(Sender: TObject; var Key: Char);
const Digit: Set of Char=['0' .. '9'];
begin
 if (Sender as TRzEdit).Name='RzEditSizeLimit' then
  begin
  if  not(Key in Digit) and (key<>chr(8)) and (key<>FormatSETTINGS.DecimalSeparator) and
    (key<>';') then key:=#0
  end
 else
  if  not(Key in Digit) and (key<>chr(8)) and (key<>FormatSETTINGS.DecimalSeparator) then key:=#0;
end;


procedure TFmDublicat.CopyFileExProgress(const AFrom,ATo:String);
begin
 with FileCopier do
  begin
   Source:=AFrom;Dest:=ATo;CopyBreak:=false;Copy;
  end;
end;


procedure TFmDublicat.SetTaskProgress(newValue: Integer;Max: Integer);
begin
 if Assigned(TaskBarList) then
    TaskBarList.SetProgressValue(FmDublicat.handle,newValue,Max);
end;

procedure TFmDublicat.setTaskStopViewProg;
begin
 if Assigned(TaskBarList) then
   TaskBarList.SetProgressState(FmDublicat.handle,TBPF_NOPROGRESS);
end;

procedure TFmDublicat.CopyFilesOfList(List:TStringList;PathTarget:String);
var   FSource,FDest:string;
      i:integer;
      Msg:TMessage;
begin
//  AddEchoText(RzRichEditEchoCom,'Копирование файлов из '+PathFolder,clGreen);
//  RzLabelNameFile.Caption:=MinimizeName(PathFolder,RzLabelNameFile.Canvas,RzLabelNameFile.Width);
 DublThread.Synchronize(procedure
  begin
    ProgressBarAll.Position:=0;
    ProgressBarAll.Max:=List.Count;
    RzPanelProgress.Visible:=true;
  end);

  for i:=0 to List.Count-1 do
   begin

    if DublThread.Stop then
     begin
      ThreadTerminated(Msg);break;
     end;

    if (TAtribClass(List.Objects[i]).Action='del') then DelFiles(List[i],false)
    else
    if (TAtribClass(List.Objects[i]).Action='copy') or
      (TAtribClass(List.Objects[i]).Action='move') then
     with TAtribClass(List.Objects[i]) do
      begin
        FSource:=List[i];
        FDest:=PathTarget+DName;
        if not(DirectoryExists(ExtractFileDir(FDest))) then  ForceDirectories(ExtractFileDir(FDest));
        DublThread.Synchronize(procedure
         begin
           RzLabelNameFile.Caption:=MinimizeName(FSource,RzLabelNameFile.Canvas,RzLabelNameFile.Width)
         end);
        CopyFileExProgress(FSource,FDest);
        if (TAtribClass(List.Objects[i]).Action='move') then
               DelFiles(FSource,false);
       DublThread.Synchronize(procedure
        begin
         ProgressBarFile.Position:=ProgressBarFile.Max;
        end);

      end;
     DublThread.Synchronize(procedure
      begin
        ProgressBarAll.Position:=ProgressBarAll.Position+1;
        SetTaskProgress(ProgressBarAll.Position,ProgressBarAll.Max);
      end);
   end;

 DublThread.Synchronize(procedure
  begin
   ProgressBarAll.Position:=ProgressBarAll.Max;Timer1.Enabled:=true;
   setTaskStopViewProg;
   if RadioButtonMove.Checked then
    AddEchoText(RzRichEditEchoCom,'Перенос файлов завершен...',clGreen,1)
    else
    if RadioButtonCopy.Checked then
      AddEchoText(RzRichEditEchoCom,'Копирование файлов завершено...',clGreen,1)
    else
    if RadioButtonDelete.Checked then
        AddEchoText(RzRichEditEchoCom,'Дубликаты файлов удалены...',clGreen,1);
  end);
end;

procedure TFmDublicat.FormCreate(Sender: TObject);
var tbList:ITaskBarList;
    hr : HRESULT;
begin

 RzPanelProgressCreateList.Visible:=False;
 RzBitBtnStopCompare.Visible:=False;
 RzLabelBreak.Visible:=False;

 RzLabelVersion.Caption:=RzVersionInfo1.FileVersion;

 TbList:=CreateComObject(CLSID_TaskBarList) as ITaskBarList;
 hr:=TbList.QueryInterface(IID_ITaskBarList3,taskBarList);
 if hr<>S_OK then
  begin
   taskBarList := nil;
   tbList._Release;
  end;

 FileCopier:=TFileCopier.Create;
 FileCopier.ProgressBar:=ProgressBarFile;
 FileCopier.MemoResult:=RzRichEditEchoCom;

 DragAcceptFiles(ListBoxListPath.Handle, true);
 DragAcceptFiles(EditDistPath.Handle, true);
 EditDistPath.Text:=ExtractFilePath(ParamStr(0));
 ProgressBarFile.Position:=0;NZapisey:=0;
 ListBoxListPath.Font.Color:= clGray;
 ButtonRun.Enabled:=False;
 RzRichEditEchoCom.Clear;
 RzPanelProgress.Visible:=False;

 with FormatSettings do
  begin
    LongMonthNames[1]  := 'Января';
    LongMonthNames[2]  := 'Февраля';
    LongMonthNames[3]  := 'Марта';
    LongMonthNames[4]  := 'Апреля';
    LongMonthNames[5]  := 'Мая';
    LongMonthNames[6]  := 'Июня';
    LongMonthNames[7]  := 'Июля';
    LongMonthNames[8]  := 'Августа';
    LongMonthNames[9]  := 'Сентября';
    LongMonthNames[10]  := 'Октября';
    LongMonthNames[11]  := 'Ноября';
    LongMonthNames[12]  := 'Декабря';
  end;

 AddEchoText(RzRichEditEchoCom,'Старт программы. Сейчас '+
 FormatDateTime('d mmmm yyyy "г - " dddd',Now)+'. Время: '+TimeToStr(Time)+'.',clMaroon,0);
end;

procedure TEdit.WMDROPFILES(var Msg: TMessage);
var
pcFileName: PChar;
i, iSize, iFileCount: integer;
begin
  pcFileName := '';
  iFileCount := DragQueryFile(Msg.wParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
   begin
    iSize := DragQueryFile(Msg.wParam, i, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    DragQueryFile(Msg.wParam, i, pcFileName, iSize);
    if DirectoryExists(pcFileName) then
    Text:=IncludeTrailingBackslash(pcFilename);
    StrDispose(pcFileName);
   end;
 DragFinish(Msg.wParam);
end;


procedure TListBox.WMDROPFILES(var Msg: TMessage);
var pcFileName: PChar;
    i,iSize,iFileCount: integer;
begin
 pcFileName := '';

 iFileCount := DragQueryFile(Msg.wParam, $FFFFFFFF, pcFileName, 255);
  for i := 0 to iFileCount - 1 do
   begin
    iSize := DragQueryFile(Msg.wParam, i, nil, 0) + 1;
    pcFileName := StrAlloc(iSize);
    DragQueryFile(Msg.wParam, i, pcFileName, iSize);
    if DirectoryExists(pcFileName) then
    if Items.IndexOf(Trim(pcFilename)) < 0 then
     begin
      if items[0]='перетащи из проводника'  then
      begin clear;Font.color:=clWindowText end;
      Items.Add(pcFilename);
     end;
     StrDispose(pcFileName);
   end;
 if count>0 then TFmDublicat(Owner).ButtonRun.Enabled:=True;

 DragFinish(Msg.wParam);
end;



procedure TFmDublicat.ButtonRunClick(Sender: TObject);
var k,i,j,IndexDubl:integer;
    CompareItem:TAtribClass;
    Dubl:boolean;
    Index,Name:string;
begin
 if ListBoxListPath.Count=0 then exit;
 DublConf.Init(FmDublicat);
 Ignor:=0;Stop:=False;
 EditDistPath.Text:=IncludeTrailingBackslash(EditDistPath.Text);
 if not(DublConf.B_Name) and not(DublConf.B_Date) then
 if  not(DublConf.R_CRC) and not(DublConf.B_Size) then
  begin
   AddEchoText(RzRichEditEchoCom,'Не выбраны параметры для поиска и сравнения файлов.',clRed,0);
   exit
  end;
 if ListBoxListPath.Items[0]='перетащи из проводника' then
  begin
   AddEchoText(RzRichEditEchoCom,'Не выбраны папки для поиска файлов.',clRed,0);
   exit
  end;

 AddEchoText(RzRichEditEchoCom,'['+TimeToStr(Time)+']  Начало выполнения операции.',clBlue,1);
 if DublConf.R_CRC then
  AddEchoText(RzRichEditEchoCom,'Подготовка данных для анализа. Расчет контрольных сумм файлов.',clBlue,0)
 else
  AddEchoText(RzRichEditEchoCom,'Подготовка данных для анализа.',clBlue,0);
 if not(DublConf.InFolder) then
         AddEchoText(RzRichEditEchoCom,'['+TimeToStr(Time)+']  Поиск файлов.',clBlue,2);


 Timer1.Enabled:=false;
 ButtonRun.Enabled:=False;
 if DublThread <> nil then
  begin
   TerminateThread(DublThread.Handle, 0);
   FreeAndNil(DublThread);
  end;

 Spisok:=TStringList.Create;
 DublThread:=TDublThread.Create(true);
 DublThread.MForm:=FmDublicat;
 DublThread.Stop:=False;
 ActivityIndicator1.Animate:=True;
 DublThread.Resume;
end;


procedure TFmDublicat.AddEchoText(Edit:TRzRichEdit;Str:String; Color: TColor;Tip:byte);
var  Pos1,Pos2: Integer;
     p: tpoint;

begin
  if color=clNone	Then Color:=clBlack;
  if Tip=0 then Edit.SelAttributes.Style:=[];
  if Tip=1 then Edit.SelAttributes.Style:=[fsBold];
  if Tip=2 then Edit.SelAttributes.Style:=[fsItalic];
  if Tip=3 then Edit.SelAttributes.Style:=[fsBold,fsItalic];

  Pos1:=Edit.Perform(EM_LINEINDEX, Edit.Lines.Count, 0);
  Edit.Lines.Add(Str);
  Pos2:=Edit.Perform(EM_LINEINDEX, Edit.Lines.Count, 0);
  Edit.Perform(EM_SETSEL, Pos1, Pos2);
  Edit.SelAttributes.Color:=Color;
//  if pos('прервана',Str)<>0 then Edit.SelAttributes.Style:=[fsBold];

//  if color=clRed then Edit.SelAttributes.Style:=[fsBold]
//  else Edit.SelAttributes.Style:=[];

  Edit.SelStart:=Length(RzRichEditEchoCom.Text);

  with Edit do
   begin
    p := point(2, ClientHeight - 2);
    Pos1 := SendMessage(Handle,EM_EXLINEFROMCHAR, 0,
         SendMessage(Handle, EM_CHARFROMPOS, 0, Integer(@p)))-
         SendMessage(Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
     Pos2:=SendMessage(Handle, EM_GETFIRSTVISIBLELINE, 0, 0);
     SendMessage(Handle, EM_LINESCROLL, 0, (Lines.Count-Pos2)-Pos1);
   end;
end;

procedure TFmDublicat.RzBtnStopCopyClick(Sender: TObject);
begin
 DublThread.Stop:=True;
 Stop:=True;
 setTaskStopViewProg;
end;

procedure TFmDublicat.ButtonCloseClick(Sender: TObject);
begin
 close
end;

procedure TFmDublicat.ListBoxListPathDblClick(Sender: TObject);
begin
 ListBoxListPath.Items.Delete(ListBoxListPath.ItemIndex);
 if ListBoxListPath.Count=0 then
  begin
   ListBoxListPath.Font.Color:=clSilver;
   ListBoxListPath.Items.Add('перетащи из проводника');
  end;

end;

procedure TFmDublicat.N1Click(Sender: TObject);
begin
 ListBoxListPath.Clear;
 ListBoxListPath.Font.Color:=clSilver;
 ListBoxListPath.Items.Add('перетащи из проводника');
end;

procedure TFmDublicat.ListBoxListPathDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  ListBoxListPath.Clear;
end;

procedure TFmDublicat.PopupMenuEchoPopup(Sender: TObject);
var re : TRzRichEdit;
begin
  re:=RzRichEditEchoCom;
  PopUndo.Enabled := re.CanUndo;
  PopCut.Enabled := re.SelText <> '';
  PopCopy.Enabled := re.SelText <> '';
//  PopClearAll.Enabled := re.SelText <> '';
  PopPast.Enabled := Clipboard.HasFormat(CF_TEXT) ;
end;

procedure TFmDublicat.PopUndoClick(Sender: TObject);
begin
  RzRichEditEchoCom.Undo
end;

procedure TFmDublicat.PopCutClick(Sender: TObject);
begin
  RzRichEditEchoCom.CutToClipboard
end;

procedure TFmDublicat.PopCopyClick(Sender: TObject);
begin
   RzRichEditEchoCom.CopyToClipboard
end;

procedure TFmDublicat.PopPastClick(Sender: TObject);
begin
   RzRichEditEchoCom.PasteFromClipboard
end;

procedure TFmDublicat.PopClearAllClick(Sender: TObject);
begin
 RzRichEditEchoCom.Clear
end;

procedure TFmDublicat.PopSelectAllClick(Sender: TObject);
begin
 RzRichEditEchoCom.SelectAll;
end;

procedure TFmDublicat.Timer1Timer(Sender: TObject);
begin
 if RzPanelProgress.Visible then RzPanelProgress.Visible:=false;
// if RzPanelProgressCreateList.Visible then RzPanelProgressCreateList.Visible:=false;
 Timer1.Enabled:=false;
end;

procedure TDublThread.DublMsgPrint;
begin
 with FmDublicat do
  case NMsg of
   1:AddEchoText(RzRichEditEchoCom,'Поиск дубликатов...',clBlue,1);
   2:AddEchoText(RzRichEditEchoCom,path+'  папка не найдена.',clRed,1);
   3:AddEchoText(RzRichEditEchoCom,#13+'Найден дубликат.'+#13+'Файл: '+FName+' <=> Папка: '+Path,clTeal,0);
   4:AddEchoText(RzRichEditEchoCom,'Файл: '+FName+' <=> Папка: '+Path,clRed,0);
   5:AddEchoText(RzRichEditEchoCom,'['+TimeToStr(Time)+'] Анализ выбранных папок завершен...',clGreen,1);
   6:AddEchoText(RzRichEditEchoCom,'['+TimeToStr(Time)+'] Операция завершена...',clBlue,1);
   7:AddEchoText(RzRichEditEchoCom,'Файлы соответсвующие фильтру не найдены.',clRed,1);
   8:AddEchoText(RzRichEditEchoCom,'Файл: '+FName+' <=> Папка: '+Path+' ошибка обработки или доступа',clFuchsia,0);
  end;

end;

procedure TDublThread.MSynchronize(_NMsg:byte;_FName:string;_Path:String);
begin
 NMsg:=_NMsg;
 Path:=_Path;
 FName:=_FName;
 Synchronize(DublMsgPrint);
end;


function TDublThread.CreateLisForCompare(PathFolder:String;Spisok:TStringList):int64;
var i:integer;
    AtribFile:TAtribClass;
    InFile : TFileStream;

begin

 // 0 все вложенные папки и файлы 1 все вложенные папки 2 файлы в указанной папке
 if MForm.DublConf.InFolder then
  for i:=0 to MForm.DublConf.ListFilter.Count-1 do
      ScanDisk(PathFolder,MForm.DublConf.ListFilter.Strings[i],Spisok,0,0,1,1)
 else
  for i:=0 to MForm.DublConf.ListFilter.Count-1 do
      ScanFile(PathFolder+'\',MForm.DublConf.ListFilter.Strings[i],Spisok,0,1);

 if MForm.DublConf.R_CRC then
  begin
   Synchronize(
   procedure
    begin
     MForm.NZapisey:=Spisok.Count;
     MForm.RzPanelProgressCreateList.Visible:=True;
     MForm.ProgressBar2.Max:=Spisok.Count;
     MForm.ProgressBar2.Position:=0;
     MForm.RzPanelEditEcho.Repaint;
    end);

    for I := 0 to Spisok.Count-1 do
     begin

      if DublThread.Stop then
       begin
        PostMessage(MForm.Handle, WM_User + 1, 0, 0);
        Result:=0;
        exit;
       end;

      DublThread.Synchronize(
       procedure
        begin
         MForm.RzLblNameFileList.Caption:=MinimizeName(Spisok[i],
                 MForm.RzLblNameFileList.Canvas,MForm.RzLblNameFileList.Width);
        end);


      if IsFileInUse(Spisok[i],MForm.DublConf.mode)=true then
       begin
         MSynchronize(8,TAtribClass(Spisok.Objects[i]).FName,TAtribClass(Spisok.Objects[i]).Path);
         TAtribClass(Spisok.Objects[i]).Skip:=true;
         continue;
       end;

      if MForm.DublConf.SizeLimit<>0 then
       begin

        if MForm.DublConf.SizeLimit>=TAtribClass(Spisok.Objects[i]).SizeFile then
          TAtribClass(Spisok.Objects[i]).crc32:=FileCRC32(Spisok[i]) else
           begin
            inc(MForm.Ignor);
            TAtribClass(Spisok.Objects[i]).Skip:=True;
           end
       end
        else TAtribClass(Spisok.Objects[i]).crc32:=FileCRC32(Spisok[i]);

      Synchronize(
       procedure
        begin
         MForm.ProgressBar2.Position:=i;
         MForm.SetTaskProgress(i,MForm.NZapisey);
        end);
     end;
       MForm.setTaskStopViewProg;
       MForm.Timer1.Enabled:=true;
  end;
{ if DublThread.Stop=True then
  begin
   PostMessage(MForm.Handle, WM_User + 1, 0, 0);
   Result:=0;
   TerminateThread(DublThread.Handle, 0);
  end else  Result:=Spisok.Count;}
  Result:=Spisok.Count;

end;


procedure TDublThread.Execute;
var CountDubl,IndexDubl,k,i,j:integer;
    CompareItem:TAtribClass;
    Dubl:boolean;
    StrInd,NameF:string;
    RecTemp:TAtribClass;
begin
 with MForm do
  begin
   //создание списка файлов с учетом заданных параметров поиска и действий
   for I:= 0 to ListBoxListPath.Count-1 do
    begin
     if DublThread.Stop then Break;
     if DirectoryExists(ListBoxListPath.Items[i]) then
      NZapisey:=CreateLisForCompare(ListBoxListPath.Items[i],Spisok)
     else
       MSynchronize(2,ListBoxListPath.Items[i],'');//'папка не найдена'
    end;

     if DublThread.Stop then
      begin
        PostMessage(MForm.Handle, WM_User + 1, 0, 0);
        exit;
      end;

   //подготовка интерфейса к поиску дубликатов синхронизация с основным потоком
    Synchronize(procedure
     begin
      ActivityIndicator1.Animate:=False;
      ProgressBar2.Position:=0;
      Timer1.Enabled:=false;
      RzPanelProgressCreateList.Visible:=False;
      RzBitBtnStopCompare.Visible:=True;
      RzLabelBreak.Visible:=True;
     end);
   if Spisok=nil then Exit;
   if Spisok.Count=0 then
    begin
     MSynchronize(7,'','');//Файлы соответсвующие фильтру не найдены
     MSynchronize(6,'','');//Операция завершена
     exit;
    end;
   MSynchronize(1,'','');//Поиск дубликатов...

   for i:=0 to Spisok.Count-1 do
    begin
     if TAtribClass(Spisok.Objects[i]).Skip then continue;
     CompareItem:=TAtribClass(Spisok.Objects[i]);
     TAtribClass(Spisok.Objects[i]).Skip:=true;IndexDubl:=0;
     if DublThread.Stop then
      begin
       PostMessage(MForm.Handle,WM_User+1,0,0);
       exit;
      end;
     for j:=0 to Spisok.Count-1 do
      begin
       RecTemp:=TAtribClass(Spisok.Objects[j]);
       Dubl:=false;
       if not(RecTemp.Skip) then
       with DublConf do
        begin
          if B_Name then
            begin
              if RecTemp.FName=CompareItem.FName then
               begin
                Dubl:=True;
                if B_Date then
                 if RecTemp.FDataTime<>CompareItem.FDataTime then Dubl:=false;
                if R_CRC then
                 if RecTemp.crc32<>CompareItem.crc32 then Dubl:=false;
                if B_Size then
                 if RecTemp.SizeFile<>CompareItem.SizeFile then Dubl:=false;
               end
              else Dubl:=false;
            end
          else
            if B_Date then
             begin
              if RecTemp.FDataTime=CompareItem.FDataTime then
               begin
                Dubl:=True;
                if R_CRC then
                 if RecTemp.crc32<>CompareItem.crc32 then Dubl:=false;
                if B_Size then
                 if RecTemp.SizeFile<>CompareItem.SizeFile then Dubl:=false;
               end
              else Dubl:=false;
             end
            else
            if B_Size then
             begin
              if RecTemp.SizeFile=CompareItem.SizeFile then
               begin
                Dubl:=True;
                if R_CRC then
                 if RecTemp.crc32<>CompareItem.crc32 then Dubl:=false;
              end else Dubl:=false;
             end
            else
             if R_CRC then
               if RecTemp.crc32=CompareItem.crc32 then Dubl:=True else Dubl:=false;
        end;

        if Dubl then
         begin
          if IndexDubl=0 then
          MSynchronize(3,CompareItem.FName,CompareItem.Path);//сравнение файлов
          MSynchronize(4,RecTemp.FName,RecTemp.Path);//Найден дубликат. Файл
          TAtribClass(Spisok.Objects[j]).Action:=DublConf.MAction;
          TAtribClass(Spisok.Objects[j]).Skip:=true;
          NameF:=TAtribClass(Spisok.Objects[j]).FName;
          k:=Length(NameF);
          StrInd:='_Dubl_'+IntToStr(IndexDubl);
          repeat dec(k) until (NameF[k]='.') or (k=0);
          if k=0 then k:=Length(NameF)+1;
          Insert(StrInd,NameF,k);
          TAtribClass(Spisok.Objects[j]).DName:=NameF;
          inc(CountDubl);inc(IndexDubl);
         end;
      end;
    end;
       //здесь копирование файлов
      RzBitBtnStopCompare.Visible:=False;
      RzLabelBreak.Visible:=False;
      if not(RadioButtonAnaliz.Checked) then CopyFilesOfList(Spisok,EditDistPath.Text);
      if RadioButtonAnaliz.Checked then MSynchronize(5,'','')//Анализ выбранных папок завершен
       else MSynchronize(6,'','');//Операция завершена...

    Synchronize(procedure
     begin
       AddEchoText(RzRichEditEchoCom,'Найдено '+IntToStr(CountDubl)+' дублирующихся файла.',clGreen,2);
       if Ignor>0  then
       AddEchoText(RzRichEditEchoCom,'Пропущено '+IntTostr(Ignor)+' файлов согласно ограничению размера',clRed,2);
     end);
   end;
   PostMessage(MForm.Handle, WM_User + 1, 0, 0);
end;


procedure TFmDublicat.popWinEditClick(Sender: TObject);
var
  MemoryStream: TMemoryStream;
begin
// if not(assigned(FmWinEdit)) then FmWinEdit:=TFmWinEdit.Create(FmDublicat);
 FmWinEdit:=TFmWinEdit.Create(FmDublicat);
  MemoryStream := TMemoryStream.Create;
  try
    RzRichEditEchoCom.Lines.SaveToStream(MemoryStream);
    MemoryStream.Seek(0, soFromBeginning);
    FmWinEdit.RzRichEditEchoWin.Lines.LoadFromStream(MemoryStream);
  finally
    MemoryStream.Free;
  end;
 FmWinEdit.RzRichEditEchoWin.SelectAll;
 FmWinEdit.RzRichEditEchoWin.SelAttributes.Size:=FmWinEdit.RzRichEditEchoWin.SelAttributes.Size+2;
 FmWinEdit.RzRichEditEchoWin.SelStart:=0;
 FmWinEdit.Show;
end;

procedure TFmDublicat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if DublThread<>nil then
  begin
   TerminateThread(DublThread.Handle, 0);
   FreeAndNil(DublThread);
  end;
  if Spisok<>nil then
   begin
    SpisokObjClear(Spisok);
    FreeAndNil(Spisok);
   end;
end;

procedure TFmDublicat.RzBitBtnStopCompareClick(Sender: TObject);
begin
 DublThread.Stop:=True;
 Stop:=true;
end;

procedure TFmDublicat.ThreadTerminated(var Msg:TMessage);
begin
 if Spisok<>nil then
  begin
   FmDublicat.SpisokObjClear(Spisok);
   FreeAndNil(Spisok);
  end;
 if DublThread<>nil then
     FreeAndNil(DublThread);
 if not(ButtonRun.Enabled) then
  begin
   ButtonRun.Enabled:=True;
   ActivityIndicator1.Animate:=False;
   RzBitBtnStopCompare.Visible:=False;
   RzLabelBreak.Visible:=False;
   RzPanelProgress.Visible:=false;
   RzPanelProgressCreateList.Visible:=false;
   if stop then
   AddEchoText(RzRichEditEchoCom,'['+TimeToStr(Time)+'] Операция прервана...',clPurple,1);
  end;
  setTaskStopViewProg;
  stop:=false
end;



end.
