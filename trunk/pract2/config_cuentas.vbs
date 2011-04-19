set shell = createobject("wscript.shell")

For i = 1 To 5
    shell.run "net user emple"&i&" /time:M-Su,08:00-15:00"
Next

WScript.Echo "Turno de emple1-5 asignado"

For i = 6 To 10
    shell.run "net user emple"&i&" /time:M-Su,14:00-21:00"
Next

WScript.Echo "Turno de emple6-10 asignado"

shell.run "net user emple1 /expires:25/10/2011"
shell.run "net user emple3 /expires:25/10/2011"
shell.run "net user emple5 /expires:25/10/2011"

WScript.Echo "Tiempo de expiración asignado"

shell.exec "cmd /k copy unidades_proyectos.bat C:\Windows\SYSVOL\sysvol\aso11.org\scripts"

For i = 1 To 10
    shell.run "net user emple" & i & " /scriptpath:unidades_proyectos.bat /homedir:\\ORD11\home\emple" & i & " /profilepath:\\ORD11\home\emple" & i
Next

WScript.Echo "Perfiles modificados"