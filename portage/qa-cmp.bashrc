# Integrates qa-cmp with portage, intended for use in /etc/portage/bashrc.
# See `qa-cmp --help` or see qa-cmp(1) man page for details.

: ${QA_CMP:=${IWDT_ALL:-y}}
: ${QA_CMP_CMD:=qa-cmp}
: ${QA_CMP_ARGS:=""}
: ${QA_CMP_LOG:=${IWDT_LOG:-eqawarn}}

qa-cmp_post_pkg_preinst() {
	[[ ${QA_CMP} == y && ${MERGE_TYPE} != binary ]] || return 0

	local output
	output=$(ROOT=${ROOT} EPREFIX=${EPREFIX} \
		"${QA_CMP_CMD}" -M ${CATEGORY}/${PN}:${SLOT} "${D}" "${@}" ${QA_CMP_ARGS} 2>&1) ||
		eerror "qa-cmp: running '${QA_CMP_CMD}' failed (disable with QA_CMP=n)"

	[[ ${output} ]] && ${QA_CMP_LOG} "${output}"
}

# vim: ts=4 ft=ebuild
