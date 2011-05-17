#!/bin/bash

ldapadd -x -D cn=admin,cn=config -H ldap://localhost -W -f ${1}
