# Integrates qa-sed with portage, intended for use in /etc/portage/bashrc.
# See `qa-sed --help` or see qa-sed(1) man page for details.

: "${QA_SED:=${IWDT_ALL:-y}}"
: "${QA_SED_CMD:=qa-sed}"
: "${QA_SED_ARGS:=""}"
: "${QA_SED_LOG:=${IWDT_LOG:-eqawarn}}"
: "${QA_SED_PHASEONLY:=y}"

sed() {
	if [[ ${QA_SED} != y || ! ${EBUILD_PHASE} || ${MERGE_TYPE} == binary ]] ||
		[[ ${QA_SED_PHASEONLY} == y && ${FUNCNAME[1]} != ${EBUILD_PHASE_FUNC} ]]
	then
		command sed "${@}"
		return ${?}
	fi

	local output errno
	{
		output=$(
			"${QA_SED_CMD}" "${@}" --qa-sed-args \
				--lineno=${BASH_LINENO[0]} --source="${BASH_SOURCE[1]}" \
				${QA_SED_ARGS} 2>&1 1>&3-
		)
		errno=${?}
	} 3>&1
	[[ ${EAPI:-0} == [0-7] ]] && output=${output//\\/\\\\\\} || output=${output//\\/\\\\}

	(( ${errno} )) && eerror "qa-sed: running '${QA_SED_CMD}' failed, broken sed? (disable with QA_SED=n)"
	[[ ${output} ]] && ${QA_SED_LOG} "${output}"

	return ${errno}
}

# vim: ts=4 ft=ebuild
