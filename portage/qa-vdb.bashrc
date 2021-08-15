# Intended for use in /etc/portage/bashrc by, for example, adding:
#
#	source /path/to/qa-vdb.bashrc
#	post_pkg_postinst() {
#		qa-vdb_post_pkg_postinst
#	}

# The following environment variables can be set in make.conf,
# bashrc, command-line, or package.env as needed:

# Set to 'y' to run qa-vdb, anything else to skip
: ${QA_VDB:=y}

# Path to qa-vdb command if not in PATH
: ${QA_VDB_CMD:=qa-vdb}

# Extra arguments to pass to qa-vdb
: ${QA_VDB_ARGS:=""}

# Message log command to use (use einfo for less noise)
: ${QA_VDB_LOG:=ewarn}

qa-vdb_post_pkg_postinst() {
	[[ ${QA_VDB} == y ]] || return

	local output
	output=$("${QA_VDB_CMD}" ${CATEGORY}/${PF} "$@" ${QA_VDB_ARGS} 2>&1) || \
		eerror "qa-vdb: running '${QA_VDB_CMD}' failed (disable with QA_VDB=n)"

	[[ ${output} ]] && ${QA_VDB_LOG} "${output}"
}

# vim: ts=4 ft=ebuild
