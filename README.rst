iwdevtools
==========

Inspired by mgorny-dev-scripts, keeping scripts I happen to
use tracked here for whomever might want to use.

Nothing here had that much care given to it and is sloppily
written, but should (I hope) still be mostly functional.

qa-vdb, qa-vdb.bashrc
---------------------
Dependencies: portage (portageq), portage-utils (qatom qfile qlist)

Tries to find issues based on information provided by VDB (/var/db/pkg).
Currently this compares RDEPEND and REQUIRES, tries to find missing
missing deps, missing binding operators, and unspecified slots (some
checks can optionally be disabled).

Example output::

    $ qa-vdb xmms2
    QA: mismatch between RDEPEND and REQUIRES (media-sound/xmms2-0.8_p20161122-r8)
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

filelist-diff.bashrc
--------------------
Dependencies: portage-utils (qatom qlist)

Show filelist differences with a replaced package post-emerge.
Ignores versions in filenames to tries and produce a shorter
list that can be quickly inspected.

Example output from portage after adding USE=caps::

    * Messages for package sys-apps/util-linux-2.37.1-r1:

    * Filelist diff:
    * +/usr/bin/setpriv
    * +/usr/share/bash-completion/completions/setpriv
    * +/usr/share/man/man1/setpriv.1.zst
