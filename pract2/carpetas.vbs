set shell = createobject("wscript.shell")

' Se crean las carpetas en el servidor
shell.exec "cmd /k mkdir c:\home"
shell.exec "cmd /k mkdir c:\proyectos"
shell.exec "cmd /k mkdir c:\proyectos\auditorio"
shell.exec "cmd /k mkdir c:\proyectos\aeropuerto"
shell.exec "cmd /k mkdir c:\proyectos\parque"

' Se comparten las carpetas home y proyectos
shell.run "net share home=c:\home /unlimited"
shell.run "net share proyectos=c:\proyectos /unlimited"

' Se asignan los permisos de carpeta compartida
shell.exec "cmd /k cacls c:\home /e /p Everyone:F"
shell.exec "cmd /k cacls c:\proyectos /e /p Everyone:F"

WScript.Echo "carpetas compartidas creadas"