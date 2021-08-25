foreach script : scripts
	subdir(script)
	foreach t : tests
		test(t, bash, suite : script,
			args : [
				files('run-test'),
				meson.current_build_dir() / script / t,
				files(script / t),
				run_script.get(script)
			],
			workdir : meson.current_source_dir() / script
		)
	endforeach
endforeach
