scripts = files(
	'qa-sed',
	'qa-vdb'
)
foreach script : scripts
	configure_file(
		install : true,
		install_dir : bindir,
		input : script,
		output : '@PLAINNAME@',
		install_mode : 'rwxr-xr-x',
		configuration : conf
	)
endforeach
