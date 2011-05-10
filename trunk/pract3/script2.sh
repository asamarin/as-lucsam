#!/bin/bash

ldapadd -x -D cn=Manager,dc=aso11,dc=org -H ldap://localhost -W -f ./ous.ldif
ldapadd -x -D cn=Manager,dc=aso11,dc=org -H ldap://localhost -W -f ./p3_passwds.ldif
ldapadd -x -D cn=Manager,dc=aso11,dc=org -H ldap://localhost -W -f ./p3_groups.ldif
