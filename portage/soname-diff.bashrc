# Show soname diff compared to previously installed version
# Similar to filelist-diff but with SONAME rather than filenames
#
# Intended for use in /etc/portage/bashrc by, for example, adding:
#
#   source /path/to/soname-diff.bashrc
#   post_pkg_preinst() {
#       soname-diff_post_pkg_preinst
#   }
#   post_pkg_postinst() {
#       soname-diff_post_pkg_postinst
#   }
#
# Dependencies:
#	app-misc/pax-utils (scanelf)
#	app-portage/portage-utils (qlist)
#	sys-apps/coreutils (sort,uniq)
#	sys-apps/grep (grep)

# The following environment variables can be set in make.conf,
# bashrc, command-line, or package.env as needed:

# Set to 'y' to perform the filelist diff, anything else to skip
: ${SONAME_DIFF:=y}

# Command to to use to generate the diff
: ${SONAME_DIFF_CMD:=diff --color=always -U0}

# Message log command to use (use einfo for less noise)
: ${SONAME_DIFF_LOG:=ewarn}

soname-diff_post_pkg_preinst() {
	SONAME_DIFF_LIST=
	[[ ${SONAME_DIFF} == y ]] || return

	local ver best=$(best_version ${CATEGORY}/${PN})
	[[ ${best} ]] || return

	SONAME_DIFF_LIST=$(
		qlist -e =${best} | grep -F '.so' | scanelf -qF'%S#F' -f - | sort | uniq
		[[ ${PIPESTATUS[*]} == '0 '[01]' 0 0 0' ]] || eerror "soname-diff: preinst qlist failed"
	)
}

soname-diff_post_pkg_postinst() {
	[[ ${SONAME_DIFF_LIST} ]] || return

	local output=$(
		${SONAME_DIFF_CMD} <(echo "${SONAME_DIFF_LIST}") <(
			qlist -e =${CATEGORY}/${PF} | grep -F '.so' | scanelf -qF'%S#F' -f - | sort | uniq
			[[ ${PIPESTATUS[*]} == '0 '[01]' 0 0 0' ]] || eerror "soname-diff: postinst qlist failed"
		) | grep -v '@@\|---\|+++'
		[[ ${PIPESTATUS[*]} == [01]\ [01] ]] || eerror "soname-diff: postinst diff failed"
	)
	[[ ${output} ]] && ${SONAME_DIFF_LOG} "DT_SONAME diff:\n${output}"
}

# vim: ts=4 ft=ebuild
