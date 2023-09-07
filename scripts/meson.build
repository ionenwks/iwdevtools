scripts = {
	'atomf' : 'format ebuild atom strings',
	'eoldnew' : 'emerge wrapper to merge the older then newest version',
	'find-unresolved' : 'find unresolved soname dependencies',
	'qa-cmp' : 'compare portage install images',
	'qa-openrc' : 'find mistakes in installed OpenRC services',
	'qa-sed' : 'sed wrapper to detect if a call did no change',
	'qa-vdb' : 'use portage VDB information to detect RDEPEND issues among others',
	'repo-cd' : 'change directory based on atom then perform actions',
	'workdir-cd' : 'change directory to workdir in PORTAGE_TMPDIR then perform actions',
	'scrub-patch' : 'strip patches of useless cruft and suggest improvements'
}

nodumpconfig = [
	'eoldnew'
]

sed = find_program('sed')
help2man = find_program('help2man', required : false)

run_script = {}
foreach script, desc : scripts
	in_script = configure_file(
		input : script,
		output : script + '.in',
		configuration : conf
	)

	run_script += {
		script :
		configure_file(
			input : in_script,
			output : '@BASENAME@',
			command : [ sed, '/#C#$/c\\. "' + common_build + '" || exit 1', '@INPUT@' ],
			capture : true
		)
	}

	install_data(
		configure_file(
			input : in_script,
			output : '@BASENAME@.out',
			command : [ sed, '/#C#$/c\\. "' + common_system + '" || exit 1', '@INPUT@' ],
			capture : true
		),
		rename : script, # help2man usage needs argv0
		install_dir : bindir,
		install_mode : 'rwxr-xr-x'
	)

	if script not in nodumpconfig
		dumpconfig = [
			'--confdir=' + meson.project_source_root() / 'config',
			'--dumpconfig'
		]
		if script == 'qa-sed'
			dumpconfig = [ '--qa-sed-args', dumpconfig ]
		endif

		custom_target(
			script + '.conf',
			output : script + '.conf',
			command : [ run_script.get(script), dumpconfig ],
			capture : true,
			env : { 'IWCOMMON_MSG_STD_FORCE' : '1' },
			install : true,
			install_dir : confdir
		)
	endif

	if help2man.found()
		custom_target(
			script + '.1',
			input : run_script.get(script),
			output : script + '.1',
			command : [ help2man, '-N', '-n', desc, '@INPUT@', '-o', '@OUTPUT@' ],
			env : {
				'ROOT' : '', 'EROOT' : eprefix, 'XDG_CONFIG_HOME' : '',
				'IWCOMMON_MSG_STD_FORCE' : '1'
			},
			install : true,
			install_dir : get_option('mandir') / 'man1'
		)
	endif
endforeach
