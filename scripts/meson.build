scripts = [
	'eoldnew',
	'qa-cmp',
	'qa-sed',
	'qa-vdb',
	'scrub-patch'
]

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
endforeach
