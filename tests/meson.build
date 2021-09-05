testconf = configuration_data()
testconf.merge_from(conf)
testconf.set('dataroot', meson.current_source_dir())
testconf.set('workroot', meson.current_build_dir())

subdir('testelf')

runtest = configure_file(
	input : 'run-test',
	output : '@PLAINNAME@',
	configuration : testconf
)

bashconf = configuration_data()
bashconf.set('datadir', bashrc_source)

bashrc = configure_file(
	input : bashrc_top,
	output : 'bashrc',
	configuration : bashconf
)

bash = find_program('bash')

foreach script, run : run_script
	subdir(script)
	foreach t : tests
		test(t, bash, suite : script, depends : testelf, timeout : 300,
			args : [ runtest, files(script / t), run ])
	endforeach
endforeach

foreach lib, inc : inc_lib
	subdir(lib)
	foreach t : tests
		test(t, bash, suite : lib,
			args : [ runtest, files(lib / t), inc, 'include' ])
	endforeach
endforeach
