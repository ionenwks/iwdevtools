Release Notes
=============

iwdevtools-next
---------------

- qa-vdb: new output format, use --unified if prefer old behavior

- qa-vdb: no longer showing unchanged deps by default, use --full to revert

- qa-vdb: new config/qa-vdb.exclude-lib primarily to skip toolchain libraries

- qa-vdb: overbind (lib:= -> lib) warning now works for SLOT=0

- qa-cmp: now ignores failed build images rather than throw spurious errors

- qa-cmp: better slot awareness, e.g. try not to compare python:3.9 with :3.10

- tests: more test cases which led to several small fixes

- tools should now be more usable on Gentoo Prefix

- basic man pages are now provided (does not say more than --help outputs)

iwdevtools-0.4.0 (2021-08-27)
-----------------------------

- qa-vdb: new config/qa-vdb.ignore to facilitate skipping packages

- qa-cmp: fix incorrect function call for new abi awareness

- qa-cmp: no longer show qlist errors on packages installing no files

iwdevtools-0.3.2 (2021-08-26)
-----------------------------

- tests: newly added to check for regressions (WIP for test cases)

- qa-cmp: abi awareness for soname lists, lets abidiff compare the right ones

- qa-cmp: no longer display header for --single-* if no output

- scrub-patch: received several small fixes for more accurate QA

iwdevtools-0.3.1 (2021-08-24)
-----------------------------

- qa-cmp: fix soname difference list so it doesn't miss entries

iwdevtools-0.3.0 (2021-08-23)
-----------------------------

- qa-cmp: provide --single-* options to display lists for a single image

- qa-cmp: fix abidiff report to be more accurate, includes some non-debug info

- eoldnew: new helper tool for using qa-cmp that emerges old version then new

iwdevtools-0.2.0 (2021-08-22)
-----------------------------

- qa-cmp(+rc): new tool for comparing installed files from images / system

- filename-diff.bashrc: removed in favor of qa-cmp.bashrc

- new IWDT_ALL envvar (default =y) to enable/disable all bashrc at once

iwdevtools-0.1.1 (2021-08-17)
-----------------------------

- qa-sed: fix broken opts parsing leading to misdetection

iwdevtools-0.1.0 (2021-08-17)
-----------------------------

- Initial release: qa-vdb(+rc), qa-sed(+rc), scrub-patch, filelist-diff.bashrc
