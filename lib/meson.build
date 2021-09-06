libs = [
	'atomf.bashlib',
	'common.bashlib'
]

lib_build = meson.current_build_dir()

inc_lib = {}
foreach lib : libs
	inc_lib += {
		lib :
		configure_file(
			install : true,
			install_dir : datadir,
			input : lib,
			output : '@PLAINNAME@',
			configuration : conf
		)
	}
	pkgconf += lib.split('.')[0] + '=${pkgdatadir}/' + lib
endforeach
