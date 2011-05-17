#!/bin/bash

ldapadd -x -D cn=Manager,dc=aso11,dc=org -H ldap://localhost -W -f ${1}
