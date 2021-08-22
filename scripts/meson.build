foreach script : [
	'qa-cmp',
	'qa-sed',
	'qa-vdb',
	'scrub-patch']
	configure_file(
		install : true,
		install_dir : bindir,
		input : script,
		output : '@PLAINNAME@',
		install_mode : 'rwxr-xr-x',
		configuration : conf
	)
endforeach
