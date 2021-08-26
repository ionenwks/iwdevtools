foreach script : scripts
	subdir(script)
	foreach t : tests
		test(t, bash, suite : script, timeout : 60,
			args : [
				files('run-test'),
				files(script / t),
				meson.current_build_dir() / script / t,
				meson.current_source_dir() / script / 'data',
				run_script.get(script)
			],
			env : [
				'PACKAGE=' + meson.project_name(),
				'VERSION=' + meson.project_version()
			]
		)
	endforeach
endforeach
