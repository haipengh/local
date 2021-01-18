#!/bin/ksh
# -----------------------------------------------------------------------------------------------
# Script  : cmsrman.sh
# -----------------------------------------------------------------------------------------------
#

usage()
{
        echo "Usage: cmsrman.sh <ORACLE_SID> <job>"
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

. /u001/local/resource/${TARGET_DB}/profile_${TARGET_DB}.env

case "${TARGET_JOB}" in
        "ONLINE"|"BACKUP_DB_ONLINE")
                run_rman "$HOME/DBA_scripts/bk_db_full_online_compress.rman";;
        "OFFLINE"|"BACKUP_DB_OFFLINE")
                run_rman "$HOME/DBA_scripts/bk_db_full_offline_compress.rman";;
        "ARCHLOG_DELETE")
                run_rman "$HOME/DBA_scripts/bk_archlog_online_compress.rman";;
        "PURGE_OBSOLETE")
                run_rman "$HOME/DBA_scripts/bk_purge.rman";;
        *)      run_rman "${TARGET_JOB}";;
esac

