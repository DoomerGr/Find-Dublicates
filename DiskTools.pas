unit DiskTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, RzTreeVw, RzPanel, RzSplit,
  RzButton, ImgList, RzShellDialogs, RzEdit, RzLstBox,Math;
procedure ScanFile(StartDir: string; Mask:string; List:TStrings;Crc:byte;CreatObj:byte);
procedure ScanDisk(StartDir: string; Mask:string;List:TStrings;Fst:word;Crc:byte;OnlyFiles:byte;CreatObj:byte);
procedure CopyFileWithProgress(const AFrom, ATo: String;Attr:Longint; var AProgress: TProgressBar);
procedure CopyFileStreamProgress(const AFrom,ATo:String;Attr:Longint; var AProgress: TProgressBar);
function RandomID(PLen: Integer): string;
function RandomNameFile(St:String;PLen: Integer): string;
function RandomWord(dictSize, lngStepSize, wordLen, minWordLen: Integer): string;
function DelDir(dir:string;ToRecycle:boolean;Progress:boolean): Boolean;
function DelFiles(const FileName: string;ToRecycle:boolean): Boolean;
function GetFileSize(FileName: String): Int64;
function GetHDSerNo:string; export;
function FileCRC32(const FileName:string):Cardinal;
function IsFileInUse(fName: string;Mode:byte) : boolean;


type

TAtribClass=class
 public
   Action:string[5];
   Skip:boolean;
   Path:shortstring;
   FName:shortstring;
   FDataTime:Double;
   SizeFile:Int64;
   crc32:Cardinal;
   DName:String;
end;


TCompareItem = record
   Action:string[5];
   Path:shortstring;
   FName:shortstring;
   FDataTime:Double;
   SizeFile:Int64;
   crc32:Cardinal;
   Index:Integer;
end;


TFolderDual = record
  PathWork:shortstring;
  PathHome:shortstring;
end;

TFileList = class(TStringList)
constructor Create;
destructor destroy;override;
end;

TProfilLine = record
   NameConf:shortstring;
   Id:string[8];
   PC:string[4];
   IdPC:string[25];
   FolderDual: array [1..10] of TFolderDual;
   LineExcept:shortstring;
   OperacDell:boolean;
   DellBasket:boolean;
   DellСonfirmat:Boolean;
   SaveLog:Boolean;
   LogExt:Boolean;
   Notransit:Boolean;
   PropuskShablon:Boolean;
   CompareContent:Boolean;
end;

 IFileCopier = interface
   ['{9ACEC816-5A3F-4BA4-95A2-B3C8CE08B82D}']
   procedure Copy;
   procedure SetProgressBar (const AProgressBar: TProgressBar);
   procedure SetCopyBreak (const ACopyBreak: boolean);
   procedure SetSource (Source: string);
   procedure SetDest (Dest: string);
   property ProgressBar: TProgressBar write SetProgressBar;
   procedure WriteMemoResult (const AMemoResult: TRzRichEdit);
   property MemoResult: TRzRichEdit write WriteMemoResult;
   property CopyBreak: boolean write SetCopyBreak;
   property Source: string write SetSource;
   property Dest: string write SetDest;

 end;

 TFileCopier = class (TInterfacedObject, IFileCopier)
 private
   FSource,FDest: string;
   FProgressBar:TProgressBar;
   FCopyBreak:boolean;
   Flag:DWORD;
   FMemoResult:TRzRichEdit;
   procedure SetPosition (APos:Int64);
 public
   constructor Create;
   procedure Copy;
   procedure SetProgressBar (const AProgressBar: TProgressBar);
   procedure WriteMemoResult (const AMemoResult: TRzRichEdit);
   procedure SetCopyBreak (const ACopyBreak: boolean);
   procedure SetSource (ASource: string);
   procedure SetDest (ADest: string);

 end;

implementation

uses ShellApi, Fm_Dublicat;

var AtribFile:TAtribClass;

function RandomWord(dictSize, lngStepSize, wordLen, minWordLen: Integer): string;
 begin
   Result := '';
   if (wordLen < minWordLen) and (minWordLen > 0) then
     wordLen := minWordLen
   else if (wordLen < 1) and (minWordLen < 1) then wordLen := 1;
   repeat
     Result := Result + Chr(Random(dictSize) + lngStepSize);
   until (Length(Result) = wordLen);
 end;

function RandomNameFile(St:String;PLen: Integer): string;
 var
   str: string;
 begin
   Randomize;
 //str:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
   str:='A1BCDEF2GHI3JK45LM6NO7PQR8ST9U0VWXYZ';
   Result:=St;
   repeat
     Result:= Result + str[Random(Length(str)) + 1];
   until (Length(Result) = PLen)
 end;

function RandomID(PLen: Integer): string;
 var
   str: string;
 begin
   Randomize;
 //str:= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
   str:='1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   Result := '';
   repeat
     Result:= Result + str[Random(Length(str)) + 1];
   until (Length(Result) = PLen)
 end;


constructor TFileList.Create;
begin
  inherited
end;


destructor TFileList.destroy;
var j:integer;
begin
  if Count>0 then
   for j:=0 to Count-1 do
    begin
     if Objects[j]<>nil then TAtribClass(Objects[j]).Free;
     Objects[j]:=nil;
    end;
  inherited
end;


//====описание класса FileCopier===============================================

constructor TFileCopier.Create;
begin
 FSource:='';FDest:='';FCopyBreak:=false;FMemoResult:=nil;
end;


function CopyCallBack (TotalFileSize,TotalBytesTransferred,StreamSize,
 StreamBytesTransferred: Int64; StreamNumber, CallBackReasom: DWORD; SrcFile,
 DestFile: THandle; FileCopier: TFileCopier): DWORD; stdcall;
begin
 FileCopier.SetPosition(TotalBytesTransferred);
 Application.ProcessMessages;
end;

{ TFileCopier }

procedure TFileCopier.Copy;
 function FileSize (const AFileName: string): Int64;
 var
   sr: TSearchRec;
 begin
    try
     if FindFirst(AFileName, faAnyFile, sr)=0 then Result:=sr.Size
     else
      begin
       FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Файл не найден: '+
                  AFileName,clRed,0);
       Result:=-1;
      end;
     except
     FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Ошибка доступа к файлу: '+
                AFileName,clRed,0);
    end;
   FindClose(sr);
 end;

var w:longbool;
    Size:Integer;
begin
 if FCopyBreak then exit;w:=false;
 if Assigned(FProgressBar) then
 begin
   FProgressBar.Position:=0;
   FProgressBar.Min:=0;
   Size:=FileSize(FSource);
   if Size<0 then exit;
   FProgressBar.Max:=Size;
 end;
 if trunc(FProgressBar.Max/1048576)>200 then flag:=COPY_FILE_NO_BUFFERING else flag:=0;
 try
  w:=CopyFileEx(PChar(FSource),PChar(FDest),@CopyCallback,Self,@FCopyBreak,flag);
   except
   end;
  if (w=false) and (FMemoResult<>nil) then
   if (GetLastError and PROGRESS_CANCEL)<>0 then
     FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,
     'Файл: '+FSource+#13+#10+'не скопирован в '+FDest,clRed,1)
   else
    if (GetLastError and ERROR_ACCESS_DENIED)<>0 then
      FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Ошибка доступа к файлу: '+
                          FSource,clRed,1)
       else FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Ошибка копирования файла: '+
                         FSource,clRed,1);
 end;

procedure TFileCopier.SetPosition(APos: Int64);
begin
 if Assigned (FProgressBar) then  FProgressBar.Position := APos
end;

procedure TFileCopier.SetProgressBar(const AProgressBar: TProgressBar);
begin
 FProgressBar := AProgressBar;
 if Assigned (FProgressBar) then  FProgressBar.Position := 0;
end;

procedure TFileCopier.WriteMemoResult(const AMemoResult: TRzRichEdit);
begin
 if AMemoResult<>nil then FMemoResult:=AMemoResult;
end;

procedure TFileCopier.SetCopyBreak (const ACopyBreak: boolean);
begin
 FCopyBreak:=ACopyBreak;
end;

procedure TFileCopier.SetSource(ASource: string);
begin
 FSource:=ASource;
end;

procedure TFileCopier.SetDest(ADest: string);
begin
 FDest:=ADest;
end;

//====конец описание класса FileCopier=========================================


Function GetHDSerNo: string; export;
var VolumeName, FileSystemName : array [0..MAX_PATH-1] of Char;
    VolumeSerialNo : Cardinal;
    MaxComponentLength, FileSystemFlags : DWORD;
Begin
 Result:='None';
 try
  GetVolumeInformation('C:\',VolumeName,MAX_PATH,@VolumeSerialNo, MaxComponentLength,FileSystemFlags,
  FileSystemName,MAX_PATH);
  Result:=IntToHex(HiWord(VolumeSerialNo),4)+ '-'+IntToHex(LoWord(VolumeSerialNo),4);
  except on EAbort do;
 end;
end;



function GetFileSize(FileName: String): Int64;
var
 FS: TFileStream;
begin
 FS:=nil;
  try
   FS:=TFileStream.Create(Filename, fmOpenRead);
   Result:=FS.Size;
   except
    FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Не могу открыть файл: '+
    Filename,clRed,1);
    Result:=-1;
  end;
   FS.Free;
end;


procedure CopyFileStreamProgress(const AFrom,ATo:String;Attr:Longint; var AProgress: TProgressBar);
const
  BlockSize = 16*1024;
var
  SStream,DStream:TFileStream;
 _Size,SizeCopied:Int64;
Begin
 if not(FileExists(AFrom)) then Exit;
 SizeCopied:=0;
  try
    SStream:=TFileStream.Create(AFrom,fmOpenRead);
    try
     DStream:=TFileStream.Create(ATo,fmCreate);
     if Assigned(AProgress) then AProgress.Max:=SStream.Size;
      Repeat
//       if FmDublicat.StopCopy then break;
       _Size:=DStream.CopyFrom(SStream,Min(BlockSize,SStream.Size-SStream.Position));
       SizeCopied:=SizeCopied+_Size;
       if Assigned(AProgress) then
        begin
         AProgress.Position := SizeCopied;
         Application.ProcessMessages;
        end;
        Application.ProcessMessages;
      Until SStream.Position>=SStream.Size;
     finally
      DStream.Free;
      FileSetDate(ATo,Attr);
    end;
   finally
   SStream.Free;
  end;
end;


procedure CopyFileWithProgress(const AFrom,ATo:String;Attr:Longint; var AProgress: TProgressBar);
const
  buflen = 1024*64;
var
  FromF, ToF: File;
  NumRead, NumWritten, DataSize: Integer;
  Buffer: array[0..buflen] of Char;
begin
  try
    DataSize := SizeOf(Buffer);
    AssignFile(FromF, AFrom);FileMode:= fmOpenRead;
    Reset(FromF,1);
    if Assigned(AProgress) then
       AProgress.Max:=FileSize(FromF);
    AssignFile(ToF, ATo);Rewrite(ToF,1);
    repeat
     BlockRead(FromF, Buffer[0], DataSize, NumRead);
     BlockWrite(ToF, Buffer[0], NumRead, NumWritten);
      if Assigned(AProgress) then
      begin
        AProgress.Position := AProgress.Position + DataSize;
        Application.ProcessMessages;
      end;
    until (NumRead = 0) or (NumWritten <> NumRead);
   finally
    CloseFile(FromF);
    CloseFile(ToF);
    FileSetDate(ATo,Attr);
  end;
end;


//создание списка файлов в список List
procedure ScanFile(StartDir: string; Mask:string; List:TStrings;Crc:byte;CreatObj:byte);
var SearchRec : TSearchRec;
    FHandle: Integer;
begin
 if FindFirst(StartDir+Mask,faAnyFile,SearchRec)=0 then
  begin
    repeat
//     Application.ProcessMessages;
     if ((SearchRec.Attr and faDirectory) <> faDirectory) and
       ((SearchRec.Name <> '..') and (SearchRec.Name <> '.')) then
      begin
        if CreatObj=1 then
          begin
           AtribFile:=TAtribClass.Create;
           AtribFile.FDataTime:=SearchRec.TimeStamp;
           AtribFile.Action:='None';
           AtribFile.DName:='';
           AtribFile.SizeFile:=SearchRec.Size;
           AtribFile.FName:=SearchRec.Name;
           AtribFile.Path:=StartDir;
           AtribFile.Skip:=False;
           if  (Length(StartDir + SearchRec.Name)<256) and (Crc=1) then
            AtribFile.Crc32:=FileCRC32(StartDir + SearchRec.Name)
           else AtribFile.Crc32:=0;
           List.AddObject(StartDir+SearchRec.Name,AtribFile);
          end
        else List.Add(StartDir+SearchRec.Name);
      end;
    until FindNext(SearchRec) <> 0;
   FindClose(SearchRec);
  end;
end;


//создание списка каталогов, файлов или каталогов + файлы в список List
procedure ScanDisk(StartDir: string; Mask:string;
                  List:TStrings;Fst:word;Crc:byte;OnlyFiles:byte;CreatObj:byte);
var SearchRec : TSearchRec;

begin
// Fst 0 все вложенные папки и файлы;
// Fst 1 все вложенные папки
// Fst 2 файлы в указанной папке

 if Fst<5 then
  begin
   if Mask='' then Mask:= '*.*';
   if StartDir[Length(StartDir)] <> '\' then StartDir:= StartDir + '\';
  end;
 if Fst=2 then begin ScanFile(StartDir,Mask,List,Crc,CreatObj);exit; end;
 if Fst=0 then ScanFile(StartDir,Mask,List,Crc,CreatObj);
 Fst:=Fst+5;
 if FindFirst(StartDir+'*.*', faDirectory+faHidden+faSysFile, SearchRec) = 0 then
  begin
    repeat
     if (SearchRec.Attr and faDirectory) = faDirectory then
      if (SearchRec.Name <> '..') and (SearchRec.Name <> '.') then
       begin
        if Fst<>6 then ScanFile(StartDir + SearchRec.Name + '\',Mask,List,Crc,CreatObj);
        ScanDisk(StartDir + SearchRec.Name + '\',Mask,List,Fst,Crc,OnlyFiles,CreatObj);
       end
      else
       if (SearchRec.Name = '..') then
        if OnlyFiles=0 then
         begin
           if CreatObj=1 then
             begin
              AtribFile:=TAtribClass.Create;
              AtribFile.FDataTime:=SearchRec.TimeStamp;
              AtribFile.Crc32:=0;
              AtribFile.Action:='Dir';
              AtribFile.Path:='';
              AtribFile.Skip:=False;
              AtribFile.DName:='';
              List.AddObject(StartDir + SearchRec.Name,AtribFile);
             end
           else List.Add(StartDir + SearchRec.Name);;
         end;
      Application.ProcessMessages;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;
end;

function DelDir(dir: string;ToRecycle:boolean;Progress:boolean): Boolean;
var
  fos: TSHFileOpStruct;
begin
 FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Удаление папки: '+dir,clGreen,0);
 Result:=false;
  try
   ZeroMemory(@fos, SizeOf(fos));
   with fos do
    begin
     wFunc:=FO_DELETE;
     fFlags:=FOF_NOCONFIRMATION;
     if Progress then fFlags:=fFlags or FOF_SIMPLEPROGRESS
      else fFlags:=fFlags or FOF_SILENT;
     if ToRecycle then  fFlags :=fFlags or FOF_ALLOWUNDO;
     pFrom  := PChar(dir + #0);
    end;
    Application.ProcessMessages;
    Result:=(0 = ShFileOperation(fos));
    except
   on Exception do
      FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Ошибка удаления папки: '+dir,clRed,1);
  end;
end;

function DelFiles(const FileName: string;ToRecycle:boolean): Boolean;
var
  fos: TSHFileOpStruct;
begin
  try
   ZeroMemory(@fos, SizeOf(fos));
   with fos do
    begin
     wFunc:=FO_DELETE;
     pFrom:=PChar(FileName+#0);
     fFlags:=FOF_NOERRORUI or FOF_SILENT or FOF_NOCONFIRMATION;
     if ToRecycle then fFlags:=fFlags or FOF_ALLOWUNDO;
    end;
    Application.ProcessMessages;
    Result := (SHFileOperation(fos) = 0) and (not fos.fAnyOperationsAborted);
    except
   on Exception do
     FmDublicat.AddEchoText(FmDublicat.RzRichEditEchoCom,'Ошибка удаления файла: '+
                                FileName,clRed,1);
  end;
end;


function FileCRC32(const FileName : string) : Cardinal;
type
  CRCTable = array [0..255] of Cardinal;
const
  BufLen = 32768;

  CRC32Table : CRCTable =
    ($00000000, $77073096, $ee0e612c, $990951ba,$076dc419, $706af48f, $e963a535, $9e6495a3,
     $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,$09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
     $1db71064, $6ab020f2, $f3b97148, $84be41de,$1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
     $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec,$14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
     $3b6e20c8, $4c69105e, $d56041e4, $a2677172,$3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
     $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940,$32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
     $26d930ac, $51de003a, $c8d75180, $bfd06116,$21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
     $2802b89e, $5f058808, $c60cd9b2, $b10be924,$2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
     $76dc4190, $01db7106, $98d220bc, $efd5102a,$71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
     $7807c9a2, $0f00f934, $9609a88e, $e10e9818,$7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
     $6b6b51f4, $1c6c6162, $856530d8, $f262004e,$6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
     $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c,$62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
     $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2,$4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
     $4369e96a, $346ed9fc, $ad678846, $da60b8d0,$44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
     $5005713c, $270241aa, $be0b1010, $c90c2086,$5768b525, $206f85b3, $b966d409, $ce61e49f,
     $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4,$59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
     $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,$ead54739, $9dd277af, $04db2615, $73dc1683,
     $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8,$e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
     $f00f9344, $8708a3d2, $1e01f268, $6906c2fe,$f762575d, $806567cb, $196c3671, $6e6b06e7,
     $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,$f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
     $d6d6a3e8, $a1d1937e, $38d8c2c4, $04fdff252,$d1bb67f1, $a6bc5767, $3fb506dd, $048b2364b,
     $d80d2bda, $af0a1b4c, $36034af6, $041047a60,$df60efc3, $a867df55, $316e8eef, $04669be79,
     $cb61b38c, $bc66831a, $256fd2a0, $5268e236,$cc0c7795, $bb0b4703, $220216b9, $5505262f,
     $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04,$c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
     $9b64c2b0, $ec63f226, $756aa39c, $026d930a,$9c0906a9, $eb0e363f, $72076785, $05005713,
     $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,$92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
     $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e,$81be16cd, $f6b9265b, $6fb077e1, $18b74777,
     $88085ae6, $ff0f6a70, $66063bca, $11010b5c,$8f659eff, $f862ae69, $616bffd3, $166ccf45,
     $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,$a7672661, $d06016f7, $4969474d, $3e6e77db,
     $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0,$a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
     $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6,$bad03605, $cdd70693, $54de5729, $23d967bf,
     $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,$b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d);

function UpdateCRC32(InitCRC : Cardinal; BufPtr : Pointer; Len : Word) : LongInt;
var
 crc: Cardinal;
 index: Integer;
 i: Cardinal;
begin
  crc := InitCRC;
  for i:=0 to Len-1 do begin
    index := (crc xor Cardinal(Pointer(Cardinal(BufPtr)+i)^)) and $000000FF;
    crc := (crc shr 8) xor CRC32Table[index];
  end;
  Result := crc;
end;


var
   InFile : TFileStream;
   crc32 : Cardinal;
   Res : Integer;
   BufPtr : Pointer;
   Buf: array [1..BufLen] of Byte;
begin
  BufPtr := @Buf;
  crc32 := $FFFFFFFF;
  try
    InFile:=TFileStream.Create(FileName,fmShareDenyNone);
    Res:=InFile.Read(Buf,BufLen);
    While (Res <> 0) do
      begin
        crc32 := UpdateCrc32(crc32,BufPtr,Res);
        Res:=InFile.Read(Buf,BufLen);
      end;
    InFile.Destroy;
  except
   on E: Exception do
     begin
       if Assigned(InFile) then InFile.Free;
       ShowMessage(Format('При обработке файла [%s] oшибка [%s]', [FileName, E.Message]));
       Result:=0;
     end;
   end;
  Result := not crc32;
end;

function IsFileInUse(fName: string;Mode:byte) : boolean;
var
  HFileRes: HFILE;
begin
 if mode=1 then  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE, 0, nil,
   OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
 else
  HFileRes := CreateFile(pchar(fName), GENERIC_READ, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then CloseHandle(HFileRes);
end;

end.

