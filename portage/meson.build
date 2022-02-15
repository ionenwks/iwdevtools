bashrcs = [
	'qa-cmp.bashrc',
	'qa-openrc.bashrc',
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

foreach bashrc : bashrcs
	pkgconf += ''.join(bashrc.split('.')[0].split('-')) + '=${pkgdatadir}/' + bashrc
endforeach

install_data(bashrcs, install_dir : datadir)
