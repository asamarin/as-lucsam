'----------------------------------------------------------
' Creating 10 User Accounts
'----------------------------------------------------------
Set objRootDSE = GetObject("LDAP://rootDSE")
Set objContainer = GetObject("LDAP://cn=Users," & _
    objRootDSE.Get("defaultNamingContext"))
 
For i = 1 To 10
    Set objLeaf = objContainer.Create("User", "cn=emple" & i)
    objLeaf.Put "sAMAccountName", "emple" & i
    objLeaf.SetInfo
Next
 
WScript.Echo "10 Usuarios creados"



'----------------------------------------------------------
' Creating OUs, groups and adding users to group
'----------------------------------------------------------

Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Aud = objDomain.Create("organizationalUnit", "ou=Auditorio")
objOU_Aud.SetInfo

Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Aer = objDomain.Create("organizationalUnit", "ou=Aeropuerto")
objOU_Aer.SetInfo

Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Par = objDomain.Create("organizationalUnit", "ou=Parque")
objOU_Par.SetInfo


'Set objOU = GetObject("LDAP://OU=Auditorio,dc=aso11,dc=org")
'Set objUser = objOU.Create("User", "cn= AckermanPilar")
'objUser.Put "sAMAccountName", "AckermanPila"
'objUser.SetInfo


'-------------- GROUPS AND USERS --------------------------------------
'Auditorio grupo director objGroupDU
'Set objOU = GetObject("LDAP://OU=Auditorio,dc=aso11,dc=org")
Set objGroupDU = objOU_Aud.Create("Group", "cn=director")
objGroupDU.Put "sAMAccountName", "director"
objGroupDU.SetInfo

Set objUser = GetObject("LDAP://cn=emple2,cn=Users,dc=aso11,dc=org")
objGroupDU.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple7,cn=Users,dc=aso11,dc=org")
objGroupDU.Add objUser.ADSPath

'Auditorio grupo participante objGroupPU
'Set objOU = GetObject("LDAP://OU=Auditorio,dc=aso11,dc=org")
Set objGroupPU = objOU_Aud.Create("Group", "cn=participante")
objGroupPU.Put "sAMAccountName", "participante"
objGroupPU.SetInfo

Set objUser = GetObject("LDAP://cn=emple1,cn=Users,dc=aso11,dc=org")
objGroupPU.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple3,cn=Users,dc=aso11,dc=org")
objGroupPU.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple4,cn=Users,dc=aso11,dc=org")
objGroupPU.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple5,cn=Users,dc=aso11,dc=org")
objGroupPU.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
objGroupPU.Add objUser.ADSPath

'Aeropuerto grupo director objGroupDR
'Set objOU_ = GetObject("LDAP://OU=Aeropuerto,dc=aso11,dc=org")
Set objGroupDR = objOU_Aer.Create("Group", "cn=director")
objGroupDR.Put "sAMAccountName", "director"
REM objGroupDR.SetInfo

Set objUser = GetObject("LDAP://cn=emple4,cn=Users,dc=aso11,dc=org")
objGroupDR.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple9,cn=Users,dc=aso11,dc=org")
objGroupDR.Add objUser.ADSPath

REM 'Aeropuerto grupo participante objGroupPE
REM 'Set objOU = GetObject("LDAP://OU=Aeropuerto,dc=aso11,dc=org")
REM Set objGroupPE = objOU_Aer.Create("Group", "cn=participante")
REM objGroupPE.Put "sAMAccountName", "participante"
REM objGroupPE.SetInfo

REM Set objUser = GetObject("LDAP://cn=emple1,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple2,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple7,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple8,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple10,cn=Users,dc=aso11,dc=org")
REM objGroupPE.Add objUser.ADSPath

REM 'Parque grupo director objGroupDP
REM 'Set objOU = GetObject("LDAP://OU=Parque,dc=aso11,dc=org")
REM Set objGroupDP = objOU_Par.Create("Group", "cn=director")
REM objGroupDP.Put "sAMAccountName", "director"
REM objGroupDP.SetInfo

REM Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
REM objGroupDP.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple8,cn=Users,dc=aso11,dc=org")
REM objGroupDP.Add objUser.ADSPath


REM 'Parque grupo participante objGroupPP
REM 'Set objOU = GetObject("LDAP://OU=Parque,dc=aso11,dc=org")
REM Set objGroupPP = objOU_Par.Create("Group", "cn=participante")
REM objGroupPP.Put "sAMAccountName", "participante"
REM objGroupPP.SetInfo

REM Set objUser = GetObject("LDAP://cn=emple3,cn=Users,dc=aso11,dc=org")
REM objGroupPP.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple5,cn=Users,dc=aso11,dc=org")
REM objGroupPP.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple9,cn=Users,dc=aso11,dc=org")
REM objGroupPP.Add objUser.ADSPath
REM Set objUser = GetObject("LDAP://cn=emple10,cn=Users,dc=aso11,dc=org")
REM objGroupPP.Add objUser.ADSPath


