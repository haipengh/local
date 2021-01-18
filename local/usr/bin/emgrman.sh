#!/bin/ksh
# $Header: /u999/cvsadmin/cms_rep/repository/local/usr/bin/emgrman.sh,v 1.1 2011/01/13 02:38:14 hongh Exp $
# -----------------------------------------------------------------------------------------------
# Script  : cmsrman.sh
# -----------------------------------------------------------------------------------------------
#

usage()
{
        echo "Usage: emgrman.sh <ORACLE_SID> <job>"
        echo "job: BACKUP_DB_ONLINE, BACKUP_DB_OFFLINE, ARCHLOG_DELETE"
}

run_rman()
{
        rman target=/ cmdfile="${1}"
}

# check arguments
if [ $# -lt 2 ]; then
        usage
        exit 1
else
        TARGET_DB=${1}
        TARGET_JOB=${2}
fi

. /oracle/local/resource/${TARGET_DB}/profile_${TARGET_DB}.env

case "${TARGET_JOB}" in
        "ONLINE"|"BACKUP_DB_ONLINE")
                run_rman "/oracle/local/rcv/bk_db_full_online_compress.rcv";;
        "OFFLINE"|"BACKUP_DB_OFFLINE")
                run_rman "/oracle/local/rcv/bk_db_full_offline_compress.rcv";;
        "ARCHLOG_DELETE")
                run_rman "/oracle/local/rcv/bk_archlog_online_compress.rcv";;
        "PURGE_OBSOLETE")
                run_rman "/oracle/local/rcv/bk_purge.rcv";;
        *)      run_rman "${TARGET_JOB}";;
esac

