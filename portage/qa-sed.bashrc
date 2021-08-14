# Intended for use in /etc/portage/bashrc by, for example, adding:
#
#	source /path/to/qa-sed.bashrc

# The following environment variables can be set in make.conf,
# bashrc, command-line, or package.env as needed:

# Set to 'y' to run qa-sed, anything else to skip
: ${QA_SED:=y}

# Path to qa-sed command if not in PATH
: ${QA_SED_CMD:=qa-sed}

# Extra arguments to pass to qa-sed
: ${QA_SED_ARGS:=""}

# Message log command to use (use einfo for less noise)
: ${QA_SED_LOG:=ewarn}

sed() {
	if [[ ${QA_SED} != y || ! ${EBUILD_PHASE} ]]; then
		env sed "${@}"
		return ${?}
	fi

	local output errno
	{ output=$("${QA_SED_CMD}" "${@}" --qa-sed-args --func=${FUNCNAME[1]} \
		--lineno=${BASH_LINENO[0]} --source="${BASH_SOURCE[1]}" \
		${QA_SED_ARGS} 3>&2 2>&1 1>&3-); errno=${?}; } 2>&1

	(( ${errno} )) && eerror "qa-sed: running '${QA_SED_CMD}' failed (disable with QA_SED=n)"
	[[ ${output} ]] && "${QA_SED_LOG}" "${output}"

	return ${errno}
}

# vim: ts=4 ft=ebuild
