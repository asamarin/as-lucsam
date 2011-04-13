Const c_strLogonHoursMorning = "00000000FE0000FE0000FE0000FE0000FE00000000"
Const c_strLogonHoursEvening = "0000000000F80000F80000F80000F80000F8000000"
set objOctetStringM = CreateObject("AelitaEDM.EDMOctetString")
set objOctetStringE = CreateObject("AelitaEDM.EDMOctetString")
objOctetStringM.Set c_strLogonHoursMorning
objOctetStringE.Set c_strLogonHoursEvening
 
 Set objUser = GetObject("EDMS://CN=emple1,CN=Users,DC=aso11,DC=org")
 objUser.Put "logonHours", objOctetStringM.GetOctetString
 objUser.SetInfo
 WScript.Echo "OK"
