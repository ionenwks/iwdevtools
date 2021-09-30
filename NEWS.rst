Release Notes
=============

iwdevtools-next
---------------

- scripts: header of messages now use CMP:, VDB: or SED: rather than QA:

- qa-cmp: now using literal * instead of <snip> in filelist diff

iwdevtools-0.7.0 (2021-09-11)
-----------------------------

- all tools with options now support configuration files

- color codes can now be swapped, see --dumpconfig on tools supporting them

- atomf(+lib): now accepts category/pn/pf.ebuild tree-style format

- atomf(+lib): new --allow-missing to not abort if missing components

- atomf(+lib): received some usage changes that may break old scripts using it

- find-unresolved: new tool to find unresolved soname dependencies in a ROOT

- fix q tools showing debug if DEBUG is exported, e.g. by openrc-0.43.5.ebuild

- received various internal cleanups and improved error checking

iwdevtools-0.6.0 (2021-09-07)
-----------------------------

- qa-cmp: add --ver-keep,--ver-dironly for filelist version-replace behavior

- qa-vdb: fix handling of deps with wildcard slots

- eoldnew: env vars can now optionally be set in portage's make.conf

- eoldnew: add two new env vars to pass arguments either only to old or new

- atomf.bashlib: new bash utility library to split portage atoms and versions

- atomf: new basic frontend to atomf.bashlib

- now providing a pkg-config file to get paths to bash include files

iwdevtools-0.5.3 (2021-09-04)
-----------------------------

- qa-vdb: fix regression causing to miss some dependencies from RDEPEND

iwdevtools-0.5.2 (2021-09-04)
-----------------------------

- qa-cmp: new shortcut option (-x/--no-compare) that equals -fsazr

- qa-cmp: fix scanelf sporadic failure when passed wrong files (hopefully)

- qa-vdb: skip some checks if package uses no shared libs, e.g. scripts-only

- bashrc information was moved to --help text and man pages of commands

iwdevtools-0.5.1 (2021-09-01)
-----------------------------

- qa-vdb: use LDPATH checks to avoid wrong lib providers, e.g. firefox-bin

- qa-vdb: fix occasional crash from new output format

iwdevtools-0.5.0 (2021-09-01)
-----------------------------

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
