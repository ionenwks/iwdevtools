=============
Release Notes
=============

iwdevtools-next
===============

Changes
-------
- qa-openrc: new script (WIP)

- qa-cmp: replacing versions in lists by ``*`` is now more restrictive to
  avoid (some) cases like PV=1 doing ``python3.10 -> python3.*0`` when mostly
  want ``doc/name-1 -> doc/name-*`` (i.e. not show same docs as new files)

- qa-sed: can now detect if only one of ``-e s/// -e s///`` did no changes, and
  no longer loads/compares with bash (should be faster, still no tmp files)

- qa-sed: now display any no-op expressions on their own lines with expanded
  variables so can see, e.g. ``s|lib|$(get_libdir)| -> s|lib|lib|``

- atomf.bashlib: add atoma() to set an associative array, e.g. atom[version]

- atomf.bashlib. add atomset() to set e.g. P=name-1.0.0, PN=name, PV=1.0, ...

Fixes
-----
- atomf.bashlib: recognize app-emacs/diff-mode--20180427 as a valid atom

- atomf.bashlib: fix atomf %S and %U format when slots have non-numbers

- qa-cmp / find-unresolved: fix when filelists contain a '$' sign

- qa-cmp: fix occasional showing of version-replaced ``-file* +file*`` when it
  should be hidden

- qa-vdb: fix using --no-ldpath when /etc/ld.so.conf doesn't exist

- qa-vdb: fix off-by-one that could sometime skip a line in non-unified diff,
  (note: 1.10.1-r2 had this fix in Gentoo)

- qa-vdb: fix >=0.8.0 regression that could give spurious reports with crossdev
  packages, e.g. believing ``cross-*/gcc`` provides ``libatomic.so.1`` (note:
  1.10.1-r1 had this fix in Gentoo)

iwdevtools-0.10.1 (2022-02-13)
==============================

Fixes
-----
- qa-vdb: workaround issue when using qfile on usr-merge systems (#5)

- qa-sed.bashrc: fix redirections to allow use with ``ebuild --debug`` (#6)

iwdevtools-0.10.0 (2022-01-21)
==============================

Changes
-------
- qa-cmp: will now display file permissions on changes, old behavior with
  -p/--ignore-perms or can show even if unchanged with -P/--show-perms
  (qa-cmp -PFx would show a single package's full filelist with permissions)

Fixes
-----
- atomf.bashlib: workaround strange bash behavior on non-Linux (macOS prefix)

iwdevtools-0.9.0 (2022-01-19)
=============================

Changes
-------
- eoldnew: add support to replace {} by the package atom in _ARGS env vars

- support using an alternate "getopt" binary to help Gentoo Prefix

iwdevtools-0.8.1 (2021-12-03)
=============================

Fixes
-----
- scripts: workaround portageq errors during portage python migration

- qa-sed: silence spurious "null byte" messages

iwdevtools-0.8.0 (2021-09-30)
=============================

Changes
-------
- scripts: header of messages now use CMP:, VDB: or SED: rather than QA:

- portage: default to eqawarn (reminder to add qa to PORTAGE_ELOG_CLASSES)

- portage: add IWDT_LOG to globally change portage output command

- qa-cmp: now using literal * instead of <snip> in filelist diff

iwdevtools-0.7.0 (2021-09-11)
=============================

Changes
-------
- all tools with options now support configuration files

- color codes can now be swapped, see --dumpconfig on tools supporting them

- atomf(+lib): now accepts category/pn/pf.ebuild tree-style format

- atomf(+lib): new --allow-missing to not abort if missing components

- atomf(+lib): received some usage changes that may break old scripts using it

- find-unresolved: new tool to find unresolved soname dependencies in a ROOT

Fixes
-----
- fix q tools showing debug if DEBUG is exported, e.g. by openrc-0.43.5.ebuild

Misc
----
- received various internal cleanups and improved error checking

iwdevtools-0.6.0 (2021-09-07)
=============================

Changes
-------
- qa-cmp: add --ver-keep,--ver-dironly for filelist version-replace behavior

- eoldnew: env vars can now optionally be set in portage's make.conf

- eoldnew: add two new env vars to pass arguments either only to old or new

- atomf.bashlib: new bash utility library to split portage atoms and versions

- atomf: new basic frontend to atomf.bashlib

- now providing a pkg-config file to get paths to bash include files

Fixes
-----
- qa-vdb: fix handling of deps with wildcard slots

iwdevtools-0.5.3 (2021-09-04)
=============================

Fixes
-----
- qa-vdb: fix regression causing to miss some dependencies from RDEPEND

iwdevtools-0.5.2 (2021-09-04)
=============================

Changes
-------
- qa-cmp: new shortcut option (-x/--no-compare) that equals -fsazr

Fixes
-----
- qa-cmp: fix scanelf sporadic failure when passed wrong files (hopefully)

- qa-vdb: skip some checks if package uses no shared libs, e.g. scripts-only

Misc
----
- bashrc information was moved to --help text and man pages of commands

iwdevtools-0.5.1 (2021-09-01)
=============================

Fixes
-----
- qa-vdb: use LDPATH checks to avoid wrong lib providers, e.g. firefox-bin

- qa-vdb: fix occasional crash from new output format

iwdevtools-0.5.0 (2021-09-01)
=============================

Changes
-------
- qa-vdb: new output format, use --unified if prefer old behavior

- qa-vdb: no longer showing unchanged deps by default, use --full to revert

- qa-vdb: new config/qa-vdb.exclude-lib primarily to skip toolchain libraries

Fixes
-----
- qa-vdb: overbind (lib:= -> lib) warning now works for SLOT=0

- qa-cmp: now ignores failed build images rather than throw spurious errors

- qa-cmp: better slot awareness, e.g. try not to compare python:3.9 with :3.10

- tools should now be more usable on Gentoo Prefix

Misc
----
- basic man pages are now provided (does not say more than --help outputs)

- tests: more test cases which led to several small fixes

iwdevtools-0.4.0 (2021-08-27)
=============================

Changes
-------
- qa-vdb: new config/qa-vdb.ignore to facilitate skipping packages

Fixes
-----
- qa-cmp: fix incorrect function call for new abi awareness

- qa-cmp: no longer show qlist errors on packages installing no files

iwdevtools-0.3.2 (2021-08-26)
=============================

Fixes
-----
- qa-cmp: abi awareness for soname lists, lets abidiff compare the right ones

- qa-cmp: no longer display header for --single-* if no output

- scrub-patch: received several small fixes for more accurate QA

Misc
----
- tests: newly added to check for regressions (WIP for test cases)

iwdevtools-0.3.1 (2021-08-24)
=============================

Fixes
-----
- qa-cmp: fix soname difference list so it doesn't miss entries

iwdevtools-0.3.0 (2021-08-23)
=============================

Changes
-------
- qa-cmp: provide --single-* options to display lists for a single image

- qa-cmp: abidiff is more accurate, includes some non-debug info

- eoldnew: new helper tool for using qa-cmp that emerges old version then new

iwdevtools-0.2.0 (2021-08-22)
=============================

Changes
-------
- qa-cmp(+rc): new tool for comparing installed files from images / system

- filename-diff.bashrc: removed in favor of qa-cmp.bashrc

- new IWDT_ALL envvar (default =y) to enable/disable all bashrc at once

iwdevtools-0.1.1 (2021-08-17)
=============================

Fixes
-----
- qa-sed: fix broken opts parsing leading to misdetection

iwdevtools-0.1.0 (2021-08-17)
=============================

- Initial release: qa-vdb(+rc), qa-sed(+rc), scrub-patch, filelist-diff.bashrc
