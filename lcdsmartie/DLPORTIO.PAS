unit DLPortIO;

interface

function DlPortReadPortUchar(poort: Word): Byte; stdcall; external 'dlportio.dll';
{Public Declare Function DlPortReadPortUshort Lib "dlportio.dll" (ByVal Port As Long) As Integer
Public Declare Function DlPortReadPortUlong Lib "dlportio.dll" (ByVal Port As Long) As Long

Public Declare Sub DlPortReadPortBufferUchar Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
Public Declare Sub DlPortReadPortBufferUshort Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
Public Declare Sub DlPortReadPortBufferUlong Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
}
procedure DlPortWritePortUchar(poort: Word; Value: Byte); stdcall; external 'dlportio.dll';
//Public Declare Sub DlPortWritePortUshort Lib "dlportio.dll" (ByVal Port As Long, ByVal Value As Integer);
//Public Declare Sub DlPortWritePortUlong Lib "dlportio.dll" (ByVal Port As Long, ByVal Value As Long);
{
Public Declare Sub DlPortWritePortBufferUchar Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
Public Declare Sub DlPortWritePortBufferUshort Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
Public Declare Sub DlPortWritePortBufferUlong Lib "dlportio.dll" (ByVal Port As Long, Buffer As Any, ByVal Count As Long)
}
implementation

end.
 