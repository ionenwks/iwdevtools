iwdevtools
==========

Inspired by `mgorny-dev-scripts`_, keeping scripts I happen to
use tracked here for whomever might want to use.

Nothing here had that much care given to it and is sloppily
written, but should (I hope) still be mostly functional.

.. _mgorny-dev-scripts: https://github.com/mgorny/mgorny-dev-scripts

qa-vdb
------
Dependencies: portage (portageq), portage-utils (qatom qfile qlist)

Tries to find issues based on information provided by VDB (/var/db/pkg).
Currently this compares RDEPEND and DT_NEEDED (i.e. from ``scanelf -n``)
for missing missing dependencies, looks for missing binding operators or
unspecified slots, then suggest changes with a diff style output.

Exclusions can be set using config files or command line, either global
or per packages if something is known to be right or irrelevant.

Example output::

    $ qa-vdb xmms2
    QA: detected possibly incorrect RDEPEND (media-sound/xmms2-0.8_p20161122-r8)
    dev-db/sqlite <
    dev-libs/glib | dev-libs/glib:2
                  > media-libs/libogg
                  > sys-libs/readline:=

Says sqlite seems unused despite being in RDEPEND (xmms2 did implement its own
database backend), and it's linking with libogg and readline with current USE
without RDEPEND. glib -> glib:2 is to suggest explicit SLOT use when available
(can be disabled with --no-slot among other options).

Alternate output::

    $ qa-vdb --unified gnome-terminal
    QA: detected possibly incorrect RDEPEND (x11-terms/gnome-terminal-3.40.3)
    +dev-libs/atk
    -dev-libs/libpcre2
    +x11-libs/libX11
    +x11-libs/pango

Run ``qa-vdb --help`` or see **qa-vdb(1)** man page for details.

qa-sed
------
Wrapper for sed that will notify if files were unmodified by the expression.
Primarily intended to be integrated with portage than used directly.

Example output from portage::

    * Messages for package app-arch/gzip-1.10

    * QA: following sed did not cause any changes
    *     sed -e "s:${EPREFIX}/usr:${EPREFIX}:" -i "${ED}"/bin/gunzip || die

Run ``qa-sed --help`` or see **qa-sed(1)** man page for details.

qa-cmp
------
Dependencies: pax-utils (scanelf), portage (portageq), portage-utils
(qatom qlist), libabigail (abidiff, optional)

Compares an image (i.e. ``/var/tmp/portage/<category>/<package>/image``) with
either another image or installed files, then consolidates differences.
Will display added and removed files, DT_SONAME changes, ABI changes on
libraries without a new DT_SONAME (requires ``abidiff`` and debug symbols
for proper checks), and size difference if above a certain threshold.

For filelist differences, by default package version is stripped from
filenames (<snip>) to reduce odds of showing uninteresting changes that
aren't *new* files. SONAME list will still show these either way.

Example output from portage (bashrc) while 0.15.1b-r4 is installed::

    # emerge -1 =libid3tag-0.16.1-r1
    [...]
    * QA: comparing =media-libs/libid3tag-0.15.1b-r4 with media-libs/libid3tag-0.16.1-r1/image
    *  FILES:+usr/lib64/cmake/id3tag/id3tagConfig.cmake
    *  FILES:+usr/lib64/cmake/id3tag/id3tagConfigVersion.cmake
    *  FILES:+usr/lib64/cmake/id3tag/id3tagTargets-gentoo.cmake
    *  FILES:+usr/lib64/cmake/id3tag/id3tagTargets.cmake
    *  FILES:-usr/lib64/libid3tag.so.0
    *  FILES:-usr/lib64/libid3tag.so.0.3.0
    *  FILES:+usr/lib64/libid3tag.so.<snip>
    * SONAME:-libid3tag.so.0(64)
    * SONAME:+libid3tag.so.0.16.1(64)
    * ------> FILES(+5,-2) SONAME(+1,-1)

It can pick the two latest ``ebuild install`` for a package and ignore
the system's copy with ``-I/--image-only``, so for a direct-use qa-cmp
example that's also using ``abidiff`` for `bug #616054`_::

    # ebuild libcdio-paranoia-0.93_p1-r1.ebuild clean install
    # ebuild libcdio-paranoia-0.94_p1.ebuild clean install
    # qa-cmp -I libcdio-paranoia
    QA: comparing dev-libs/libcdio-paranoia-0.93_p1-r1/image with dev-libs/libcdio-paranoia-0.94_p1/image
     FILES:-usr/share/doc/libcdio-paranoia-${PV}/README.zst
     FILES:+usr/share/doc/libcdio-paranoia-${PV}/README.md.zst
       ABI: libcdio_cdda.so.2(64) func(+12,-25) vars(+3) [BREAKING]
       ABI: libcdio_paranoia.so.2(64) func(+47,-10) vars(+3,-1) [BREAKING]
    ------> FILES(+1,-1) ABI(+65,-36,>B<)

.. _bug #616054: https://bugs.gentoo.org/616054

Run ``qa-cmp --help`` or see **qa-cmp(1)** man page for details.

eoldnew
-------
Dependencies: portage (portageq), portage-utils (qatom)

Helper for using ``qa-cmp`` which emerges a package for a given atom but
by first emerging its previous (visible) version if not already installed.

Example usage::

    $ eoldnew iwdevtools --quiet --pretend
    old: app-portage/iwdevtools-0.1.1
    new: app-portage/iwdevtools-0.2.0
    running: emerge =app-portage/iwdevtools-0.1.1 --quiet --pretend
    [ebuild  N    ] app-portage/iwdevtools-0.1.1
    running: emerge iwdevtools --quiet --pretend
    [ebuild  N    ] app-portage/iwdevtools-0.2.0

Run ``eoldnew --help`` or see **eoldnew(1)** man page for details.

scrub-patch
-----------
Perhaps copying the ``sed`` from the `devmanual`_ was too much of a hassle?
Well this is the script for you!

.. _devmanual: https://devmanual.gentoo.org/ebuild-writing/misc-files/patches/index.html

May possibly do a bit more...

Run ``scrub-patch --help`` or see **scrub-patch(1)** man page for details.

Bashlibs
========

Primarily intended for internal use, but exposing for anyone that may need.
May potentially be subject to breaking changes for the time being.

atomf.bashlib
-------------

Basic bash functions to split portage atoms and version strings for when
matching on ``-[0-9]*`` is just not cutting it. Similar to **qatom(1)** in
term of base functionality.

.. code-block:: bash

	#!/usr/bin/env bash
	. "$(pkg-config iwdevtools --variable=atomf)"

	atomf 'ver:%v rev:%R\n' 'cat/pn-1.0-r1' # ver:1.0 rev:1

	atomsp myarray '>=cat/pn-1.0-r1:3/0'
	echo "ver:${myarray[4]} slot:${myarray[6]}" # ver:1.0 slot:3

	pversp myarray '1.0b_alpha3_p8-r1'
	echo "${myarray[*]}" # 1 .0 b _alpha 3 _p 8 -r1

Can also use the command line frontend::

	$ atomf 'cat:%c name:%n pvr:%v%r\n' */*/*.ebuild
	cat:acct-group name:abrt pvr:0-r1
	[...]

Run ``atomf --help`` or see **atomf(1)** man page for details.

Installing
==========

On Gentoo, simply ``emerge app-portage/iwdevtools``

Or for a manual install:

- mkdir build && cd build
- meson --prefix /path/to/prefix
- meson test
- meson install

To (optionally) integrate with portage, an example bashrc will be installed
at ``<prefix>/share/iwdevtools/bashrc`` which can be either symlinked to or
sourced from ``/etc/portage/bashrc``.

See the various individual .bashrc for options (such as to pass arguments, or
the enable/disable all switch: ``IWDT_ALL=y`` [default] / ``=n``), or to
integrate manually with a custom bashrc.

Note: pkgcore is unsupported, both for integration and merged packages in VDB
