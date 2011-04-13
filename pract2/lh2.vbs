'Const c_strLogonHoursMorning = "00000000FE0000FE0000FE0000FE0000FE00000000"
'Const c_strLogonHoursEvening = "0000000000F80000F80000F80000F80000F8000000"
Dim arraydelcarajo(20)

arraydelcarajo(0) = &H00
arraydelcarajo(1) = &H00
arraydelcarajo(2) = &H00
arraydelcarajo(3) = &H00
arraydelcarajo(4) = &H00
arraydelcarajo(5) = &H00
arraydelcarajo(6) = &H00
arraydelcarajo(7) = &H00
arraydelcarajo(8) = &H00
arraydelcarajo(9) = &H00
arraydelcarajo(10) = &H00
arraydelcarajo(11) = &H00
arraydelcarajo(12) = &H00
arraydelcarajo(13) = &H00
arraydelcarajo(14) = &H00
arraydelcarajo(15) = &H00
arraydelcarajo(16) = &H00
arraydelcarajo(17) = &H00
arraydelcarajo(18) = &H00
arraydelcarajo(19) = &H00
arraydelcarajo(20) = &H00

'set objOctetStringM = CreateObject("AelitaEDM.EDMOctetString")
'set objOctetStringE = CreateObject("AelitaEDM.EDMOctetString")
'objOctetStringM.Set c_strLogonHoursMorning
'objOctetStringE.Set c_strLogonHoursEvening
 
Set objUser = GetObject("LDAP://CN=emple1,CN=Users,DC=aso11,DC=org")
' objUser.Put "logonHours", objOctetStringM.GetOctetString
arrLogonHours = objUser.Get("logonHours")

objUser.Put "logonHours", arraydelcarajo
objUser.SetInfo
WScript.Echo "OK"
