project('iwdevtools',
	version : '0.1.0',
	meson_version : '>=0.49.0')

prefix = get_option('prefix')
bindir = get_option('bindir')
datadir = get_option('datadir') / meson.project_name()

docdir = get_option('docdir')
if docdir == ''
	docdir = meson.project_name()
endif
docdir = get_option('datadir') / 'doc' / docdir

sed = find_program('sed')
custom_target('bashrc',
	install : true,
	install_dir : datadir,
	input : 'portage/bashrc.in',
	output : 'bashrc',
	capture : true,
	command : [sed, 's|%DATADIR%|' + prefix / datadir + '|', '@INPUT@' ])

install_data(['NEWS.rst', 'README.rst'],
	install_dir : docdir)
install_subdir('portage',
	exclude_files : 'bashrc.in',
	install_dir : datadir,
	strip_directory : true)
install_subdir('scripts',
	install_dir : bindir,
	install_mode : 'rwxr-xr-x',
	strip_directory : true)
