project('ionen-dev-scripts',
	version : '0.1.0',
	meson_version : '>=0.47.0')

bindir = get_option('bindir')
datadir = join_paths(get_option('datadir'), meson.project_name())
docdir = get_option('docdir')
if docdir == ''
	docdir = join_paths(get_option('datadir'), 'doc', meson.project_name())
endif

install_data(['NEWS.rst','README.rst'],
	install_dir : docdir)
install_subdir('portage',
	install_dir : datadir,
	strip_directory : true)
install_subdir('scripts',
	install_dir : bindir,
	install_mode : 'rwxr-xr-x',
	strip_directory : true)
