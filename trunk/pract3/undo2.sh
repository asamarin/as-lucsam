#!/bin/bash

ldapdelete -x -D cn=Manager,dc=aso11,dc=org -H ldap://localhost -W -f aborrar.txt
