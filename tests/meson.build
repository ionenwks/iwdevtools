testconf = configuration_data()
testconf.set('package', meson.project_name())
testconf.set('version', meson.project_version())
testconf.set('dataroot', meson.current_source_dir())
testconf.set('workroot', meson.current_build_dir())

subdir('testelf')

runtest = configure_file(
	input : 'run-test',
	output : '@PLAINNAME@',
	configuration : testconf
)

bash = find_program('bash')

foreach script : scripts
	subdir(script)
	foreach t : tests
		test(t, bash, suite : script, timeout : 60,
			args : [
				runtest,
				files(script / t),
				run_script.get(script)
			],
			depends : testelf
		)
	endforeach
endforeach
