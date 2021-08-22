configure_file(
	install : true,
	install_dir : datadir,
	input : 'bashrc',
	output : '@PLAINNAME@',
	configuration : conf
)

install_data([
	'filelist-diff.bashrc',
	'soname-diff.bashrc',
	'qa-cmp.bashrc',
	'qa-sed.bashrc',
	'qa-vdb.bashrc'],
	install_dir : datadir)
