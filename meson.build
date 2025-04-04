project(
	'iwdevtools',
	license : 'BSD-2-Clause',
	version : '0.12.16',
	meson_version : '>=1.1'
)

prefix = get_option('prefix')
bindir = get_option('bindir')
confdir = get_option('sysconfdir') / meson.project_name()
datadir = get_option('datadir') / meson.project_name()
eprefix = get_option('eprefix')
getopt = get_option('getopt')

docdir = get_option('docdir')
if docdir == ''
	docdir = meson.project_name()
endif
docdir = get_option('datadir') / 'doc' / docdir

docs = [
	'NEWS.rst',
	'README.rst'
]

conf = configuration_data()
conf.set('confdir', prefix / confdir)
conf.set('datadir', prefix / datadir)
conf.set('package', meson.project_name())
conf.set('version', meson.project_version())
conf.set('eprefix', '"${EPREFIX=' + eprefix + '}" #')
conf.set('getopt', '"${getopt:=' + getopt + '}" #')

pkgconf = [ 'pkgdatadir=' + prefix / datadir ]

subdir('config')
subdir('lib')
subdir('portage')
subdir('scripts')

if get_option('test')
	subdir('tests')
endif

import('pkgconfig').generate(
	name : meson.project_name(),
	description : meson.project_name() + ' bash include files',
	dataonly : true,
	install_dir : get_option('datadir') / 'pkgconfig',
	variables : pkgconf
)

install_data(docs, install_dir : docdir)
