Const MIN_IN_DAY = 1440
Const SEC_IN_MIN = 60
Const HUNDRED_NS_IN_SEC = 10000000
 
'Set objDomain = GetObject("WinNT://aso11")
Set objAdS = GetObject("LDAP://dc=aso11,dc=org")
Set objMaxPwdAge = objAdS.Get("maxPwdAge")
'WScript.Echo objMaxPwdAge.LowPart & "; " & objMaxPwdAge.HighPart
' Seteo cosas!
'objDomain.Put "MaxPasswordAge", 30 * MIN_IN_DAY * SEC_IN_MIN
'objAds.Put "minPwdLength", 9
'objAds.Put "LowPart", 5000
objAds.Put "maxPwdAge", 90 * MIN_IN_DAY * SEC_IN_MIN '* 10 * 1000 * 1000
objAds.SetInfo

WScript.Echo "Hecho"



'intMaxPwdAgeSeconds = objDomain.Get("MaxPasswordAge")
'intMinPwdAgeSeconds = objDomain.Get("MinPasswordAge")
'intLockOutObservationWindowSeconds = objDomain.Get("LockoutObservationInterval")
'intLockoutDurationSeconds = objDomain.Get("AutoUnlockInterval")
'intMinPwdLength = objAds.Get("minPwdLength")
 
'intPwdHistoryLength = objAds.Get("pwdHistoryLength")
'intPwdProperties = objAds.Get("pwdProperties")
'intLockoutThreshold = objAds.Get("lockoutThreshold")
'intMaxPwdAgeDays = _
'  ((intMaxPwdAgeSeconds/SEC_IN_MIN)/MIN_IN_DAY) & " days"
'intMinPwdAgeDays = _
'  ((intMinPwdAgeSeconds/SEC_IN_MIN)/MIN_IN_DAY) & " days"
'intLockOutObservationWindowMinutes = _
'  (intLockOutObservationWindowSeconds/SEC_IN_MIN) & " minutes"
' 
'If intLockoutDurationSeconds <> -1 Then
'  intLockoutDurationMinutes = _
'(intLockOutDurationSeconds/SEC_IN_MIN) & " minutes"
'Else
'  intLockoutDurationMinutes = _
'    "Administrator must manually unlock locked accounts"
'End If
' 
'WScript.Echo "maxPwdAge = " & intMaxPwdAgeDays
'WScript.Echo "minPwdAge = " & intMinPwdAgeDays
'WScript.Echo "minPwdLength = " & intMinPwdLength
'WScript.Echo "pwdHistoryLength = " & intPwdHistoryLength
'WScript.Echo "pwdProperties = " & intPwdProperties
'WScript.Echo "lockOutThreshold = " & intLockoutThreshold
'WScript.Echo "lockOutObservationWindow = " & intLockOutObservationWindowMinutes
'WScript.Echo "lockOutDuration = " & intLockoutDurationMinutes




