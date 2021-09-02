scripts = [
	'eoldnew',
	'qa-cmp',
	'qa-sed',
	'qa-vdb',
	'scrub-patch'
]

help2man = find_program('help2man', required : false)

run_script = {}

foreach script : scripts
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
			command : [ help2man, '-N', '@INPUT@', '-o', '@OUTPUT@' ],
			env : { 'ROOT' : '', 'EROOT' : eprefix },
			install : true,
			install_dir : get_option('mandir') / 'man1'
		)
	endif
endforeach
