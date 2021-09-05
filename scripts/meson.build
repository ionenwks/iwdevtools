scripts = {
	'eoldnew' : 'emerge wrapper to merge the older then newest version',
	'qa-cmp' : 'compare portage install images',
	'qa-sed' : 'sed wrapper to detect if a call did no change',
	'qa-vdb' : 'use portage VDB information to detect RDEPEND issues among others',
	'scrub-patch' : 'strip patches of useless cruft and suggest improvements'
}

help2man = find_program('help2man', required : false)

run_script = {}
foreach script, desc : scripts
	run_script += {
		script :
		configure_file(
			install : true,
			install_dir : bindir,
			input : script,
			output : '@PLAINNAME@',
			install_mode : 'rwxr-xr-x',
			configuration : conf
		)
	}

	if help2man.found()
		custom_target(
			script + '.1',
			input : run_script.get(script),
			output : '@PLAINNAME@.1',
			command : [ help2man, '-N', '-n', desc, '@INPUT@', '-o', '@OUTPUT@' ],
			env : { 'ROOT' : '', 'EROOT' : eprefix, 'XDG_CONFIG_HOME' : '' },
			install : true,
			install_dir : get_option('mandir') / 'man1'
		)
	endif
endforeach
