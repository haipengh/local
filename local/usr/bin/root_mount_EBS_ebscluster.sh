#!/bin/ksh
#$Header: /u999/cvsadmin/cms_rep/repository/local/usr/bin/root_mount_EBS_ebscluster.sh,v 1.2 2017/11/01 01:47:53 cvsadmin Exp $
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
_PRG_HEADER="$Id: root_mount_EBS_ebscluster.sh,v 1.2 2017/11/01 01:47:53 cvsadmin Exp $"

#_EXEC_BIN="template.am"
_EXEC_BIN=`echo "${_PRGID}" | cut -d'.' -f1`.am

amwrapper.sh "${_EXEC_BIN}" "${_PRGID}" "${@}"
