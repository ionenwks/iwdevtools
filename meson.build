project(
	'iwdevtools',
	version : '0.3.0',
	meson_version : '>=0.50.0'
)

prefix = get_option('prefix')
bindir = get_option('bindir')
confdir = get_option('sysconfdir') / meson.project_name()
datadir = get_option('datadir') / meson.project_name()

docdir = get_option('docdir')
if docdir == ''
	docdir = meson.project_name()
endif
docdir = get_option('datadir') / 'doc' / docdir

conf = configuration_data()
conf.set('confdir', prefix / confdir)
conf.set('datadir', prefix / datadir)
conf.set('version', meson.project_version())

subdir('config')
subdir('portage')
subdir('scripts')

install_data([
	'NEWS.rst',
	'README.rst'],
	install_dir : docdir
)
