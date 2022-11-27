# Integrates qa-vdb with portage, intended for use in /etc/portage/bashrc
# See `qa-vdb --help` or see qa-vdb(1) man page for details.

: ${QA_VDB:=${IWDT_ALL:-y}}
: ${QA_VDB_CMD:=qa-vdb}
: ${QA_VDB_ARGS:=""}
: ${QA_VDB_LOG:=${IWDT_LOG:-eqawarn}}

qa-vdb_post_pkg_postinst() {
	[[ ${QA_VDB} == y ]] || return

	local output
	output=$("${QA_VDB_CMD}" ${CATEGORY}/${PF} "$@" ${QA_VDB_ARGS} 2>&1) || \
		eerror "qa-vdb: running '${QA_VDB_CMD}' failed (disable with QA_VDB=n)"

	[[ ${output} ]] && ${QA_VDB_LOG} "${output}"
}

# vim: ts=4 ft=ebuild
