libs = [
	'common.bashlib',
	'atomf.bashlib'
]

common_system = prefix / datadir / libs[0]
common_build = meson.current_build_dir() / libs[0]

inc_lib = {}
foreach lib : libs
	inc_lib += {
		lib :
		configure_file(
			install : true,
			install_dir : datadir,
			input : lib,
			output : lib,
			configuration : conf
		)
	}
	pkgconf += lib.split('.')[0] + '=${pkgdatadir}/' + lib
endforeach
