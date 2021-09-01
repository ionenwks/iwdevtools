bashrcs = [
	'qa-cmp.bashrc',
	'qa-sed.bashrc',
	'qa-vdb.bashrc'
]

bashrc_top = files('bashrc')
bashrc_source = meson.current_source_dir()

configure_file(
	install : true,
	install_dir : datadir,
	input : bashrc_top,
	output : '@PLAINNAME@',
	configuration : conf
)

install_data(bashrcs, install_dir : datadir)
