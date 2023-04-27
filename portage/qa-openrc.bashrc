# Integrates qa-cmp with portage, intended for use in /etc/portage/bashrc.
# See `qa-cmp --help` or see qa-cmp(1) man page for details.

: ${QA_OPENRC:=${IWDT_ALL:-y}}
: ${QA_OPENRC_CMD:=qa-openrc}
: ${QA_OPENRC_ARGS:=""}
: ${QA_OPENRC_LOG:=${IWDT_LOG:-eqawarn}}

qa-openrc_post_pkg_preinst() {
	[[ ${QA_OPENRC} == y && ${MERGE_TYPE} != binary ]] || return 0

	local output
	output=$(ROOT=${ROOT} EPREFIX=${EPREFIX} \
		"${QA_OPENRC_CMD}" "${D}" "${@}" ${QA_OPENRC_ARGS} 2>&1) ||
		eerror "qa-openrc: running '${QA_OPENRC_CMD}' failed (disable with QA_OPENRC=n)"

	[[ ${output} ]] && ${QA_OPENRC_LOG} "${output}"
}

# vim: ts=4 ft=ebuild
