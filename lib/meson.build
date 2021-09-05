libs = [
	'atomf.bashlib'
]

inc_lib = {}
foreach lib : libs
	inc_lib += { lib : files(lib) }
	pkgconf += lib.split('.')[0] + '=${pkgdatadir}/' + lib
endforeach

install_data(libs, install_dir : datadir)
