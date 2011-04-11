Dim arrLogonHoursBytes(20)
Dim arrLogonHoursBits(167)
arrDayOfWeek = Array _
  ("Sun", "Mon", "Tue", "Wed", _
   "Thu", "Fri", "Sat")

Set objUser = GetObject _
  ("LDAP://cn=emple1,cn=Users,dc=aso11,dc=org")
objUser.GetInfoEx Array("LogonHours"), 0
arrLogonHours = objUser.Get("LogonHours")

For i = 1 To LenB(arrLogonHours)
     arrLogonHoursBytes(i-1) = AscB(MidB(arrLogonHours, i, 1))
Next

intCounter = 0
intLoopCounter = 0
WScript.Echo "Day  Byte 1   Byte 2   Byte 3"
REM For Each LogonHourByte In arrLogonHoursBytes
  REM arrLogonHourBits = GetLogonHourBits(LogonHourByte)
  
For i = 0 to 6
	SetLogonHourBits arrLogonHoursBytes(i*3), 1, "eve"
	SetLogonHourBits arrLogonHoursBytes(i*3+1), 2, "eve"
	SetLogonHourBits arrLogonHoursBytes(i*3+2), 3, "eve"
Next
for i = 0 to 20
	WScript.Echo arrLogonHoursBytes(i)
next
   REM If intCounter = 0 Then
    REM WScript.Echo arrDayOfWeek(intLoopCounter) & Space(2)
    REM intLoopCounter = intLoopCounter + 1
  REM End If

    REM For Each LogonHourBit In arrLogonHourBits
        REM WScript.Echo LogonHourBit
        REM intCounter = 1 + intCounter

        REM If intCounter = 8 or intCounter = 16 Then
          REM WScript.Echo Space(1)
        REM End If
        
        REM If intCounter = 24 Then
          REM WScript.echo VbCr
          REM intCounter = 0
        REM End If 
    REM Next
REM Next

REM For i = 1 To LenB(arrLogonHours)
    REM arrLogonHours(i-1)  = arrLogonHoursBytes(i-1)
REM Next


'objUser.Put "LogonHours", arrLogonHoursBytes
'objUser.SetInfo


WScript.echo "Hecho !"

REM Function GetLogonHourBits(x)
    REM Dim arrBits(7)
    REM For i = 7 to 0 Step -1
        REM If x And 2^i Then
            REM arrBits(i) = 1
        REM Else
            REM arrBits(i) = 0
        REM End If
    REM Next
    REM GetLogonHourBits = arrBits
REM End Function

Sub SetLogonHourBits(ByRef arrBits, ByVal byte_, ByVal turno)
	REM Dim arrBits as Byte
	If turno = "Morning" Then
		Select Case byte_ 
			Case 1
				arrBits = &H00
			Case 2
				arrBits = &HFE
			Case 3
				arrBits = &H00
		End Select
	Else
		Select Case byte_ 
			Case 1
				arrBits = &H00
			Case 2
				arrBits = &H00
			Case 3
				arrBits = &HF8
		End Select
	End If
End Sub