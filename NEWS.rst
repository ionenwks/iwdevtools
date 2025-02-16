=============
Release Notes
=============

iwdevtools-next
===============

Fixes
=====
- qa-vdb.*: update pkgmoved packages in default configs

iwdevtools-0.12.14 (2024-12-04)
===============================

Fixes
=====
- scrub-patch: do not abort and suggest ``-s/--no-sanity`` when file(1) version
  5.46 newly recognizes patches with a ``From`` line as an mbox file rather
  than a patch
- tests: adjust scrub-patch tests for file-5.46

iwdevtools-0.12.13 (2024-09-22)
===============================

Fixes
=====
- tests: work around a potential(?) portage bug that lead to tests being
  confused by dev-python/test newly existing in the Gentoo tree
- general: unset GENTOO_CPYTHON_BUILD to prevent potential failure of portageq
  invocations when emerging dev-lang/python

iwdevtools-0.12.12 (2024-05-31)
===============================

Changes
=======
- qa-vdb.exclude-bind(config): revert addition of clang/lld/llvm given
  llvm-r1.eclass now suggests to add the binding operator with the
  prospect of using subslots properly if ever needed

iwdevtools-0.12.11 (2024-02-09)
===============================

Changes
=======
- qa-vdb.exclude-bind(config): exclude sys-devel/clang, sys-devel/lld, and
  sys-devel/llvm by default to avoid noise with the upcoming llvm-r1.eclass

iwdevtools-0.12.10 (2024-01-12)
===============================

Fixes
=====
- repo-cd: allow usage even when the current directory was deleted

iwdevtools-0.12.9 (2024-01-03)
==============================

Fixes
=====
- qa-cmp: prevent permission differences from being displayed with symbolic
  links, what is reported can vary between filesystems and causes noise

iwdevtools-0.12.8 (2023-09-22)
==============================

Changes
=======
- qa-vdb: default configs now exclude libcxx, libcxxabi, and llvm-libunwind
  from being a missing dependency candidate (but note that llvm-libunwind
  may still be needed if used directly by the package)

- repo-cd: support codeberg remote-id

iwdevtools-0.12.7 (2023-08-04)
==============================

Changes
-------
- qa-cmp: replace SLOT in paths alongside versions with ``*`` to allow
  ignoring in file lists differences (only relevant when emerging a new
  SLOT or else same-SLOT is compared when using portage hooks)

- qa-cmp: also replace versions for, e.g. ``.so.<slot|version>`` as these
  should be compared using the SONAME lists instead (note that this will
  replace the common ``.so.0`` with SLOT=0 but is not considered an issue)

iwdevtools-0.12.6 (2023-07-30)
==============================

Changes
-------
- scrub-patch: standardize gentoo's bugzilla urls (and few others) in headers

iwdevtools-0.12.5 (2023-05-26)
==============================

Changes
-------
- portage: disable checks for binpkgs (only comes into effect for new binpkgs)

iwdevtools-0.12.4 (2023-03-20)
==============================

Changes
-------
- qa-vdb.exclude-bind(config): exclude gobject-introspection by default, been
  common practice to keep the binding operator even if it has no subslot (yet)
  in case the introspection format changes

- qa-vdb.exclude-extra(config): exclude gobject-introspection by default, very
  few packages actually link with the library

iwdevtools-0.12.3 (2023-02-08)
==============================

Changes
-------
- qa-cmp: also omit ``/usr/src/debug/*`` from output alongside already omitted
  ``/usr/lib/debug/*`` to avoid ``FEATURES=installsources/splitdebug`` noise

iwdevtools-0.12.2 (2022-12-19)
==============================

Changes
-------
- qa-cmp: add ``--timeout=[seconds]`` option to stop ``abidiff`` when taking
  too long (defaults to 10 seconds, can set to 0 for the old behavior)

iwdevtools-0.12.1 (2022-11-30)
==============================

Changes
-------
- scrub-patch: no longer try to remove mbox signatures, this is fragile and
  does not always give expected results

Fixes
-----
- qa-cmp: ignore abidiff errors for stub libraries, prevents aborting
  the entire process

- scrub-patch: fix -e/--edit to work with stdin, aka can do:
  ``diff -Nur a b | scrub-patch --edit > edited-in-vim.patch``

iwdevtools-0.12.0 (2022-10-24)
==============================

Changes
-------
- scrub-patch: -e/--edit option to open patch in $EDITOR after scrubbing,
  primarily for those that prefer to view/edit the clean patch (e.g. to
  add links) and have it verified for QA oversights only after

- scrub-patch: -g/--git option to auto-convert e.g. ``leading-1.0/file`` to
  git-style ``a/file`` (not default given would be harmful on a -p0 patch,
  but is safe to always use with -p1 patches)

- scrub-patch: -1/--p0p1 option to add a leading directory to every files,
  i.e. convert a -p0 patch to -p1

- repo-cd: tentatively support upcoming ``kde-invent`` remote-id

Fixes
-----
- repo-cd: for tab completion, do not give mismatching ``_`` and ``-`` results
  to the shell as it will not know they are interchangeable and misbehave

- qa-sed.bashrc: prevent portage from interpreting e.g. ``\r`` from sed
  expressions in the log output

iwdevtools-0.11.9 (2022-09-19)
==============================

Fixes
-----
- repo-cd: fix typo in ``freedesktop-gitlab`` and ``gnome-gitlab`` urls

iwdevtools-0.11.8 (2022-09-16)
==============================

Changes
-------
- repo-cd: support new ``freedesktop-gitlab``, ``gnome-gitlab``, ``savannah``
  and ``savannah-nongnu`` remote-ids

- scrub-patch: give a better error when file(1) did not recognize a patch

iwdevtools-0.11.7 (2022-08-19)
==============================

Fixes
-----
- qa-sed: do not test ``-e`` individually if they can't function that way,
  e.g. when using sed labels (unfortunately means this can't tell if each
  separate use of labels replaced something)

- qa-sed: avoid occasional incorrect modification when expression testing
  failed but normal sed command didn't resulting in sed being run multiple
  times by the error handler (currently only known affected case is
  ``sys-apps/shadow[pam]`` login.defs superfluous comments, this is further
  fixed given doesn't error out with sed labels anymore)

iwdevtools-0.11.6 (2022-08-10)
==============================

Changes
-------
- repo-cd: ``.`` can now be passed to ``--path/-P`` to search the repo
  from current working directory without needing to explicitly add, new
  default is ``--path="default:."``

Fixes
-----
- qa-cmp: fix wrong error message occasionally being shown on files limit

iwdevtools-0.11.5 (2022-07-29)
==============================

Changes
-------
- repo-cd: similarly to case insensitivity, consider ``_`` and ``-`` the same
  when searching (includes tab completion), e.g. ``SDL2_im<tab> -> sdl2-image``

- repo-cd: support new ``hackage`` and ``sourcehut`` remote-ids

Fixes
-----
- repo-cd: don't fallback to fuzzy search if match was exact except for letter
  case (e.g. ``rcd pyqt5`` will cd to ``PyQt5`` without ``PyQt5-sip`` prompt)

iwdevtools-0.11.4 (2022-07-19)
==============================

Changes
-------
- repo-cd: fallback to fuzzy search if no exact name match (e.g. ``rcd sdl2-``
  gives a list of choices even without tab completion), and add -f/-F options
  to control the behavior like forcing fuzzy even if an exact match

- qa-vdb: print warning about QML for dev-qt/ and kde-frameworks/ when
  suggesting removal as it's often incorrect if using qtdeclarative
  (unfortunately can't detect usage from the VDB information alone)

iwdevtools-0.11.3 (2022-07-05)
==============================

Changes
-------
- qa-cmp: abort on slow large lists, e.g. gentoo-sources unless --no-skip-large

Fixes
-----
- qa-cmp: fix version replacement by ``*`` in the common ``<ver>.dist-info``

iwdevtools-0.11.2 (2022-06-29)
==============================

Fixes
-----
- scripts: fix with bash-5.2_rc1

iwdevtools-0.11.1 (2022-06-27)
==============================

Changes
-------
- repo-cd: support tilde for command in --run=~/mycmd like --path does

- shellparse.bashlib: functions/arrays disabled by default for speedups,
  notably with repo-cd if many large ebuilds

Fixes
-----
- scripts: prevent boolean-type --no-* being passed twice from re-enabling

- qa-vdb: fix -U/--unified showing spurious unbound errors if nothing to report

- repo-cd: fix info not being displayed if using e.g. --path=./overlay

iwdevtools-0.11.0 (2022-06-24)
==============================

New
---
- repo-cd: new tool to jump to the directory of a package's atom then display
  information such as remote-ids or a custom command's output (can search for
  a partial atom, and use tab completion with bash/fish/zsh after setting up
  shell integration)

- qa-openrc: contributed script to do basic /etc/init.d checks

- qa-openrc.bashrc: requires addition of ``qa-openrc_post_pkg_preinst`` to
  ``post_pkg_preinst`` if not using the default bashrc

Changes
-------
- scripts: ``*.conf`` files to set default options or configure colors are now
  installed by default so it's more obvious than running ``--dumpconfig`` (#8)

- qa-cmp: replacing versions in lists by ``*`` is now more restrictive to
  avoid (some) cases like PV=1 doing ``python3.10 -> python3.*0`` when mostly
  want ``doc/name-1 -> doc/name-*`` (i.e. not show same docs as new files)

- qa-sed: can now detect if only one of ``-e s/// -e s///`` did no changes

- qa-sed: now display any no-op expressions on their own lines with expanded
  variables so can see, e.g. ``s|lib|$(get_libdir)| -> s|lib|lib|``

- qa-sed: no longer compares with bash (should be faster, still no tmp files)

- atomf.bashlib: add ``atoma()`` for associative, e.g. ``atom[version]``

- atomf.bashlib: add ``atomset()`` to set e.g. ``P=name-1.0.0``, ``PV=1.0``, ...

Fixes
-----
- atomf.bashlib: recognize ``app-emacs/diff-mode--20180427`` as a valid atom

- atomf.bashlib: fix atomf %S and %U format when slots have non-numbers

- qa-cmp / find-unresolved: fix when filelists contain a ``$`` sign

- qa-cmp: fix occasional showing of version-replaced ``-file* +file*`` when it
  should be hidden

- qa-vdb: fix bad display on slot change, e.g. ``python:3.10 | python:3.11``
  showing red 0 and green 1 at end when it was rather removing ``python:3.10``

- qa-vdb: fix using ``--no-ldpath`` when ``/etc/ld.so.conf`` doesn't exist

- qa-vdb: fix off-by-one that could sometime skip a line in non-unified diff,
  (note: ``1.10.1-r2`` had this fix in Gentoo)

- qa-vdb: fix ``>=0.8.0`` regression that could give spurious reports with
  crossdev packages, e.g. believing ``cross-*/gcc`` provides ``libatomic.so.1``
  (note: ``1.10.1-r1`` had this fix in Gentoo)

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

New
---
- find-unresolved: find unresolved soname dependencies in a ROOT

Changes
-------
- all tools with options now support configuration files

- color codes can now be swapped, see --dumpconfig on tools supporting them

- atomf(+lib): now accepts category/pn/pf.ebuild tree-style format

- atomf(+lib): add --allow-missing to not abort if missing components

- atomf(+lib): received some usage changes that may break old scripts using it

Fixes
-----
- fix q tools showing debug if DEBUG is exported, e.g. by openrc-0.43.5.ebuild

Misc
----
- received various internal cleanups and improved error checking

iwdevtools-0.6.0 (2021-09-07)
=============================

New
---
- atomf.bashlib: bash utility library to split portage atoms and versions

- atomf: basic frontend to atomf.bashlib

Changes
-------
- qa-cmp: add --ver-keep,--ver-dironly for filelist version-replace behavior

- eoldnew: env vars can now optionally be set in portage's make.conf

- eoldnew: add two new env vars to pass arguments either only to old or new

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
- qa-cmp: add shortcut option (-x/--no-compare) that equals -fsazr

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

- qa-vdb: add config/qa-vdb.exclude-lib primarily to skip toolchain libraries

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
- qa-vdb: add config/qa-vdb.ignore to facilitate skipping packages

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

New
---
- eoldnew: helper tool for using qa-cmp that emerges old version then new

Changes
-------
- qa-cmp: provide --single-* options to display lists for a single image

- qa-cmp: abidiff is more accurate, includes some non-debug info

iwdevtools-0.2.0 (2021-08-22)
=============================

New
---
- qa-cmp(+rc): new tool for comparing installed files from images / system

Changes
-------
- filename-diff.bashrc: removed in favor of qa-cmp.bashrc

- add IWDT_ALL envvar (default =y) to enable/disable all bashrc at once

iwdevtools-0.1.1 (2021-08-17)
=============================

Fixes
-----
- qa-sed: fix broken opts parsing leading to misdetection

iwdevtools-0.1.0 (2021-08-17)
=============================

- Initial release: qa-vdb(+rc), qa-sed(+rc), scrub-patch, filelist-diff.bashrc
