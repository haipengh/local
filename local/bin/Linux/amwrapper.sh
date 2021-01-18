#!/bin/ksh
_PRG=${0}
_PRGID=`basename ${0}`

if [ $# -lt 2 ]; then
	echo "Usage: ${_PRGID} <program> <program_name> [arguments]"
	exit 1
else
	_EXEC_BIN="${1}"
	_EXEC_NAME="${2}"
	shift 2
fi
$(amwrapper-ldr.exe "${_EXEC_BIN}" "${_EXEC_NAME}") "${@}"
