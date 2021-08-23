Release Notes
=============

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
