#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/bin/Linux/template.sh,v 1.1 2010/11/14 21:12:27 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : template.sh
# Changes :
#           Seq Name       Date       Description
#           --- ---------- ---------- -----------------------------------------------------------
#           000            1997/02/17 initial creation.
# -----------------------------------------------------------------------------------------------
#

_PRG=${0}
_PRGID=`basename ${0}`
_PRG_HEADER="$Id: template.sh,v 1.1 2010/11/14 21:12:27 hongh Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"

