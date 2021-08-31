# Intended for use in /etc/portage/bashrc by, for example, adding:
#
#	source /path/to/qa-cmp.bashrc
#	post_pkg_preinst() {
#		qa-cmp_post_pkg_preinst
#	}
#
# Dependencies:
#	app-portage/iwdevtools (qa-cmp)

# The following environment variables can be set in make.conf,
# bashrc, command-line, or package.env as needed:

# Set to 'y' to run qa-cmp, anything else to skip
: ${QA_CMP:=${IWDT_ALL:=y}}

# Path to qa-cmp command if not in PATH
: ${QA_CMP_CMD:=qa-cmp}

# Extra arguments to pass to qa-cmp
: ${QA_CMP_ARGS:=""}

# Message log command to use (use einfo for less noise)
: ${QA_CMP_LOG:=ewarn}

qa-cmp_post_pkg_preinst() {
	[[ ${QA_CMP} == y ]] || return

	local output
	output=$("${QA_CMP_CMD}" -M ${CATEGORY}/${PN}:${SLOT} =${CATEGORY}/${PF} "$@" ${QA_CMP_ARGS} 2>&1) || \
		eerror "qa-cmp: running '${QA_CMP_CMD}' failed (disable with QA_CMP=n)"

	[[ ${output} ]] && ${QA_CMP_LOG} "${output}"
}

# vim: ts=4 ft=ebuild
