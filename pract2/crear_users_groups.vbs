'----------------------------------------------------------
' Creating 10 User Accounts
'----------------------------------------------------------
Set objRootDSE = GetObject("LDAP://rootDSE")
Set objContainer = GetObject("LDAP://cn=Users," & _
    objRootDSE.Get("defaultNamingContext"))
 
For i = 1 To 10
    Set objLeaf = objContainer.Create("User", "cn=emple" & i)
    objLeaf.Put "sAMAccountName", "emple" & i
    objLeaf.Put "userPrincipalName", "emple" & i & "@aso11.org"
    objLeaf.SetInfo

    Set objUser = GetObject("LDAP://cn=emple" & i & ",cn=Users,dc=aso11,dc=org")
    objUser.AccountDisabled = FALSE
    objUser.SetPassword "emple" & i
    objUser.SetInfo
Next
 
WScript.Echo "10 Usuarios empleX creados"

For i = 1 To 2
    Set objLeaf = objContainer.Create("User", "cn=ejec" & i)
    objLeaf.Put "sAMAccountName", "ejec" & i
    objLeaf.Put "userPrincipalName", "ejec" & i & "@aso11.org"
    objLeaf.SetInfo

    Set objUser = GetObject("LDAP://cn=ejec" & i & ",cn=Users,dc=aso11,dc=org")
    objUser.AccountDisabled = FALSE
    objUser.SetPassword "ejec" & i
    objUser.SetInfo
Next

WScript.Echo "2 Usuarios ejecX creados"

'----------------------------------------------------------
' Creating OUs, groups and adding users to group
'----------------------------------------------------------

'-------------- OUs --------------------------------------
Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Aud = objDomain.Create("organizationalUnit", "ou=Auditorio")
objOU_Aud.SetInfo

Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Aer = objDomain.Create("organizationalUnit", "ou=Aeropuerto")
objOU_Aer.SetInfo

Set objDomain = GetObject("LDAP://dc=aso11,dc=org")
Set objOU_Par = objDomain.Create("organizationalUnit", "ou=Parque")
objOU_Par.SetInfo


'-------------- GROUPS AND USERS --------------------------------------
'Auditorio grupo director
'Set objOU = GetObject("LDAP://ou=Auditorio,dc=aso11,dc=org")
Set objGroup = objOU_Aud.Create("Group", "cn=director")
objGroup.Put "sAMAccountName", "director_Auditorio"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple2,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple7,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath

'Auditorio grupo participante
'Set objOU = GetObject("LDAP://ou=Auditorio,dc=aso11,dc=org")
Set objGroup = objOU_Aud.Create("Group", "cn=participante")
objGroup.Put "sAMAccountName", "participante_Auditorio"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple1,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
WScript.Echo objUser.ADSPath



Set objUser = GetObject("LDAP://cn=emple3,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple4,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple5,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath

'Aeropuerto grupo director
'Set objOU_ = GetObject("LDAP://ou=Aeropuerto,dc=aso11,dc=org")
Set objGroup = objOU_Aer.Create("Group", "cn=director")
objGroup.Put "sAMAccountName", "director_Aeropuerto"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple4,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple9,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath

'Aeropuerto grupo participante
'Set objOU = GetObject("LDAP://ou=Aeropuerto,dc=aso11,dc=org")
Set objGroup = objOU_Aer.Create("Group", "cn=participante")
objGroup.Put "sAMAccountName", "participante_Aeropuerto"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple1,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple2,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple7,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple8,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple10,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath

'Parque grupo director
'Set objOU = GetObject("LDAP://ou=Parque,dc=aso11,dc=org")
Set objGroup = objOU_Par.Create("Group", "cn=director")
objGroup.Put "sAMAccountName", "director_Parque"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple6,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple8,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath


'Parque grupo participante
'Set objOU = GetObject("LDAP://ou=Parque,dc=aso11,dc=org")
Set objGroup = objOU_Par.Create("Group", "cn=participante")
objGroup.Put "sAMAccountName", "participante_Parque"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=emple3,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple5,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple9,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=emple10,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath

' -------------------------
' Grupo ejecutivos
' -------------------------
Set objDomain = GetObject("LDAP://cn=Users,dc=aso11,dc=org")
Set objGroup = objDomain.Create("Group", "cn=ejecutivos")
objGroup.Put "sAMAccountName", "ejecutivos"
objGroup.SetInfo

Set objUser = GetObject("LDAP://cn=ejec1,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
Set objUser = GetObject("LDAP://cn=ejec2,cn=Users,dc=aso11,dc=org")
objGroup.Add objUser.ADSPath
