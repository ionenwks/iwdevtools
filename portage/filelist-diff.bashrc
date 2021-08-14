# Show filelist rough diff with previous while ignoring version in filenames.
# Requires app-portage/portage-utils (qlist, qatom)
#
# Intended for use in /etc/portage/bashrc by, for example, adding:
#
#   source /path/to/filelist-diff.bashrc
#   post_pkg_preinst() {
#       filelist-diff_post_pkg_preinst
#   }
#   post_pkg_postinst() {
#       filelist-diff_post_pkg_postinst
#   }

# The following environment variables can be set in make.conf,
# bashrc, command-line, or package.env as needed:

# Set to 'y' to perform the filelist diff, anything else to skip
: ${FILELIST_DIFF:=y}

# Command to to use to generate the diff
: ${FILELIST_DIFF_CMD:=diff --color=always -U0}

# Message log command to use (use einfo for less noise)
: ${FILELIST_DIFF_LOG:=ewarn}

filelist-diff-post_pkg_preinst() {
	[[ ${FILELIST_DIFF} == y ]] || return
	FILELIST_DIFF_LIST=

	local ver best=$(best_version ${CATEGORY}/${PN})
	[[ ${best} ]] || return
	ver=($(qatom -F '%{PVR} %{PV}' ${best} || eerror 'filelist-diff: preinst qatom failed'))

	FILELIST_DIFF_LIST=$(
		qlist -e =${best} | sed "s|${ver[0]}|<PV>|g;s|${ver[1]}|<PV>|g" | sort
		[[ ${PIPESTATUS[*]} == '0 0 0' ]] || eerror "filelist-diff: preinst qlist failed"
	)
}

filelist-diff-post_pkg_postinst() {
	[[ ${FILELIST_DIFF_LIST} ]] || return

	local output=$(
		${FILELIST_DIFF_CMD} <(echo "${FILELIST_DIFF_LIST}") <(
			qlist -e =${CATEGORY}/${PF} | sed "s|${PVR}|<PV>|g;s|${PV}|<PV>|g" | sort
			[[ ${PIPESTATUS[*]} == '0 0 0' ]] || eerror "filelist-diff: postinst qlist failed"
		) | grep -v '@@\|---\|+++'
		[[ ${PIPESTATUS[*]} == [01]\ [01] ]] || eerror "filelist-diff: postinst diff failed"
	)
	[[ ${output} ]] && ${FILELIST_DIFF_LOG} "Filelist diff:\n${output}"
}

# vim: ts=4 ft=ebuild
