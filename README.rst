iwdevtools
==========

Inspired by `mgorny-dev-scripts`_, keeping scripts I happen to
use tracked here for whomever might want to use.

Nothing here had that much care given to it and is sloppily
written, but should (I hope) still be mostly functional.

.. _mgorny-dev-scripts: https://github.com/mgorny/mgorny-dev-scripts

qa-vdb, qa-vdb.bashrc
---------------------
Dependencies: portage (portageq), portage-utils (qatom qfile qlist)

Tries to find issues based on information provided by VDB (/var/db/pkg).
Currently this compares RDEPEND and DT_NEEDED (i.e. from ``scanelf -n``)
for missing missing dependencies, looks for missing binding operators or
unspecified slots, then suggest changes with a -/+ diff output (some
checks can optionally be disabled).

Example output::

    $ qa-vdb xmms2
    QA: detected possibly incorrect RDEPEND (media-sound/xmms2-0.8_p20161122-r8)
    -dev-db/sqlite
    -dev-libs/glib
    +dev-libs/glib:2
    +media-libs/libogg
     media-libs/opus
     media-libs/opusfile
    +sys-libs/readline:=
     virtual/jack

Run ``qa-vdb --help`` for details, and see ``qa-vdb.bashrc`` for portage.

qa-sed, qa-sed.bashrc
---------------------
Wrapper for sed that will notify if files were unmodified by the expression.
Primarily intended to be integrated with portage than used directly.

Example output from portage::

    * Messages for package app-arch/gzip-1.10

    * QA: following sed did not cause any changes
    *     sed -e "s:${EPREFIX}/usr:${EPREFIX}:" -i "${ED}"/bin/gunzip || die

Run ``qa-sed --help`` for details, and see ``qa-sed.bashrc`` for portage.

qa-cmp, qa-cmp.bashrc
---------------------
Dependencies: pax-utils (scanelf), portage (portageq), portage-utils
(qatom qlist), libabigail (abidiff, optional)

Compares an image (i.e. ``/var/tmp/portage/<category>/<package>/image``) with
either another image or installed files, then consolidates differences.
Will display added and removed files, DT_SONAME changes, ABI changes on
libraries without a new DT_SONAME (requires ``abidiff`` and debug symbols),
and size difference if above a certain threshold.

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
    *  FILES:+usr/lib64/libid3tag.so.${PV}
    * SONAME:-libid3tag.so.0
    * SONAME:+libid3tag.so.0.16.1
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
       ABI: libcdio_cdda.so.2.0.0 func(+25,-12) vars(-3) [BREAKING]
    ------> FILES(+1,-1) ABI(+25,-15,>B<)

.. _bug #616054: https://bugs.gentoo.org/616054

Run ``qa-cmp --help`` for details, and see ``qa-cmp.bashrc`` for portage.

scrub-patch
-----------
Perhaps copying the ``sed`` from the `devmanual`_ was too much of a hassle?
Well this is the script for you!

.. _devmanual: https://devmanual.gentoo.org/ebuild-writing/misc-files/patches/index.html

May possibly do a bit more...

Run ``scrub-patch --help`` for details.
