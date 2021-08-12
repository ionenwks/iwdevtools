ionen-dev-scripts
=================

Inspired by mgorny-dev-scripts, keeping scripts I happen to
use tracked here for whomever might want to use.

Currently just one, but should increase as I slowly rework them.

Nothing here had that much care given to it and is sloppily
written, but should (I hope) still be mostly functional.

qa-vdb
------
Dependencies: portage (portageq), portage-utils (qatom qfile qlist)

Tries to find issues based on information provided by VDB (/var/db/pkg).
Currently this compares RDEPEND and REQUIRES, tries to find missing
missing deps, missing binding operators, and unspecified slots (some
checks can optionally be disabled).

Example output::

    $ qa-vdb xmms2
    * QA: mismatch between RDEPEND and REQUIRES (media-sound/xmms2-0.8_p20161122-r8)
    * -dev-db/sqlite
    * -dev-libs/glib
    * +dev-libs/glib:2
    * +media-libs/libogg
    *  media-libs/opus
    *  media-libs/opusfile
    * +sys-libs/readline:=
    *  virtual/jack

Run ``qa-vdb --help`` for details
