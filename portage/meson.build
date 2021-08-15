bashrcs = files(
	'bashrc',
	'filelist-diff.bashrc',
	'qa-sed.bashrc',
	'qa-vdb.bashrc'
)
foreach bashrc : bashrcs
	configure_file(
		install : true,
		install_dir : datadir,
		input : bashrc,
		output : '@PLAINNAME@',
		configuration : conf
	)
endforeach
