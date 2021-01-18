#!/bin/sh
TR=/usr/bin/tr
CUT=/bin/cut
AWK=/bin/awk
WC=/usr/bin/wc
CAT=/bin/cat
GREP=/bin/grep
PS=/bin/ps
SHOWMOUNT=/usr/sbin/showmount
EXPORTFS=/usr/sbin/exportfs
ACFSUTIL=/sbin/acfsutil
MNTACFS=/sbin/mount.acfs
UMNTACFS=/sbin/umount.acfs
NFSD=/etc/init.d/nfs
TOUCH=/bin/touch
RM=/bin/rm

# derive from _CRS_NAME, expect _CRS_NAME name as: d<nn>fin.acfs
_ENVID=`echo ${_CRS_NAME} | ${CUT} -d'.' -f1`
_ENVID_LOWER=`echo ${_ENVID} | ${TR} [:upper:] [:lower:]`
_ENVID_UPPER=`echo ${_ENVID} | ${TR} [:lower:] [:upper:]`
if [ "${_ENVID_LOWER}" = "sharedfin" ]; then
	_ENVID_APP_PATH="/clusterfs/ebs/shared"
else
	_ENVID_APP_PATH="/clusterfs/ebs/shared/${ENVID_LOWER}"
fi
_ENVID_MOUNTPOINT="/clusterfs/ebs"

# /etc/exports
_OS_EXPORTS="/etc/exports"

#
# These messages go into the CRSD agent log file.
echo " *******   `date` ********** "
echo "Action script '$_CRS_ACTION_SCRIPT' for resource[$_CRS_NAME] called for action $1"
#

case "$1" in
  'start')
     echo "START entry point has been called.."

     # check readability of /etc/exports
     if [ ! -r ${_OS_EXPORTS} ]; then
        echo "Error: cannot read file ${_OS_EXPORTS}"
        exit 1
     fi

     # check acfs mount exist in /etc/exports
     _CNT_EXPORT=`${CAT} ${_OS_EXPORTS} | ${AWK} '{print $1}' | ${GREP} ${_ENVID_APP_PATH} | ${WC} -l`
     if [ ${_CNT_EXPORT:-0} -le 0 ]; then
        echo "Error: there is no entry ${_ENVID_APP_PATH} in file ${_OS_EXPORTS}"
        exit 1
     fi

     # check exports entry has been export in runtime, if not run 'exportfs -a'
     _CNT_MOUNT=`${SHOWMOUNT} -d localhost | ${GREP} ${_ENVID_APP_PATH} | ${WC} -l`
     if [ ${_CNT_MOUNT:-0} -le 0 ]; then
        ${EXPORTFS} -a
     fi

     # check exports entry again, after running 'exportfs -a'
     _CNT_MOUNT=`${SHOWMOUNT} -d localhost | ${GREP} ${_ENVID_APP_PATH} | ${WC} -l`
     if [ ${_CNT_MOUNT:-0} -le 0 ]; then
        echo "Error: there is no entry ${_ENVID_APP_PATH} been exported on localhost"
        exit 1
     fi

     # get device/mount point info from 'acfs registry -l', expect return like: Device : /dev/asm/ebsapps-191 : Mount Point : /clusterfs/ebs : Options : none : Nodes : all : Disk Group : CFSDG : Volume : EBSAPPS
     # or use, acfsutil info fs -o primaryvolume <path>
     _ENVID_DEVICE=`${ACFSUTIL} registry -l ${_ENVID_MOUNTPOINT} | ${AWK} -F":" '{ for(i=1; i<=NF; i++) {if (substr($i, 1, 6) == "Device") print $++i;}}'`
     #_ENVID_DEVICE=`${ACFSUTIL} info fs -o primaryvolume ${_ENVID_MOUNTPOINT}`
     _ENVID_DEVICE=`echo ${_ENVID_DEVICE}`		# trim off space
     if [ "{_ENVID_DEVICE}" = "" ]; then
        echo "Error: cannot find device for acfs mount point ${_ENVID_MOUNTPOINT}"
        exit 1
     fi

     # mount acfs
     ${MNTACFS} ${_ENVID_DEVICE} ${_ENVID_MOUNTPOINT}
     _RETCODE=$?
     if [ ${_RETCODE} -ne 0 ]; then
        echo "Error: ${MNTACFS} ${_ENVID_DEVICE} ${_ENVID_MOUNTPOINT}"
        exit 1
     fi

     # reload NFS
     ${NFSD} reload
     _RETCODE=$?
     if [ ${_RETCODE} -ne 0 ]; then
        echo "Error: ${NFSD} reload"
        exit 1
     fi

     exit 0
     ;;

  'stop')
     echo "STOP entry point has been called.." 

     # currently we are not umount acfs as it's shared by all apps
     # do the umount once the mount point and environment is one-to-one mapped
     #${UMNTACFS} ${_ENVID_MOUNTPOINT}
     #echo "INFO: skip ${UMNTACFS} ${_ENVID_MOUNTPOINT}"

     # reload NFS
     ${NFSD} reload
     _RETCODE=$?
     if [ ${_RETCODE} -ne 0 ]; then
        echo "Error: ${NFSD} reload"
        exit 1
     fi

     exit 0
     ;;

  'check')
    echo "CHECK entry point has been called.."

    # check mount point/directory exist
    if [ ! -d ${_ENVID_APP_PATH} ]; then
       echo "Error: directory ${_ENVID_APP_PATH} is not mounted"
       exit 1
    fi

    # check nfs daemon is running
    _CNT_NFSD=`${PS} -e -o comm,pid | ${GREP} ^nfsd | ${WC} -l`
    if [ ${_CNT_NFSD:-0} -le 0 ]; then
       echo "Warning: nfs daemon is not running"
       exit 0
    fi

    ;;

  'clean')
     echo "CLEAN entry point has been called.."

     exit 0
     ;;

esac

