#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/usr/bin/asm_purge_dsc_archlog.sh,v 1.1 2019/05/10 01:56:36 cvsadmin Exp $
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
_PRG_HEADER="$Id: asm_purge_dsc_archlog.sh,v 1.1 2019/05/10 01:56:36 cvsadmin Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

if [ `whoami` = 'root' -o `whoami` = 'grid' ]; then
        /opt/amkit/local/bin/Linux/amcronjob.sh -sid=+ASM amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"
else
	amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"
fi

