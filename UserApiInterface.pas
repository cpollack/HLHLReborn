unit UserApiInterface;

interface
Const
  C_GameShareDLLName = 'gameShare.DLL';
{uses
	UserTypes;
function WinGBToBIG5(Source, Destination: PChar; iLen: integer; LanguageType: TLanguageType): WordBool; stdcall; External 'gameShare.DLL';
function WinBIG5ToGB(Source, Destination: PChar; iLen: integer; LanguageType: TLanguageType): WordBool; stdcall; External 'gameShare.DLL';
function LCMAPConvert(Source, Destination: PChar; iLen: integer; LanguageType: TLanguageType): WordBool; stdcall; External 'gameShare.DLL';}
function GetProcessID(EXE_Name: PChar): THandle;
  stdcall; External C_GameShareDLLName;
function GetModuleMainFileName(ProcessID: THandle;
  EXE_Name, ModuleMainFileName:PChar; iLen: Integer): integer;
  stdcall; External C_GameShareDLLName;
function GetProcessMemory(EXE_Name: PChar;
  Address: LongWord; Buf: Pointer; Len: LongWord): LongWord;
  stdcall; External C_GameShareDLLName;
function SetProcessMemory(EXE_Name: PChar;
  Address: LongWord; Buf: Pointer; Len: LongWord): LongWord;
  stdcall; External C_GameShareDLLName;
function GetProcessMemoryForID(ProcessID: THandle;
  Address: LongWord; Buf: Pointer; Len: LongWord): boolean;
  stdcall; External C_GameShareDLLName;
function SetProcessMemoryForID(ProcessID: THandle;
  Address: LongWord; Buf: Pointer; Len: LongWord): boolean;
  stdcall; External C_GameShareDLLName;

function GetFileVersionInVersionInfo(pFileName, pInfo:PChar;
  const BufLen:Integer):WordBool;
  stdcall; External C_GameShareDLLName;

implementation

end.

