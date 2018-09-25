man2pdf
=======

Convert Man Pages To PDF With Bookmarks.

.. figure:: screenshot.png
   :alt:

Usage
-----

::

    ./man2pdf.sh path-to-man-pages-directory

where the ``path-to-man-pages-directory`` is the root directory of the
decompressed man-pages release, which is available at `The Linux
man-pages project <https://www.kernel.org/doc/man-pages/>`__.

For example:

::

    ./man2pdf.sh ~/Documents/man-pages-4.02

Output
------

Eight manuals in PDF format, and one 32.pdf and a 64.pdf.

Dependencies
------------

-  pdfroff, which comes from the package ``groff``
-  powerful unix tools such as ``grep``
-  `pdfmark <https://github.com/NoviceLive/pdfmark>`__, I wrote

NOTE
----

You had better clone this repository with ``--depth 1`` option.

TODO
----

Improve the regex because the current is unbearably ugly

WARNING
-------

This repository was discontinued since I do not prefer PDF format any
more.

License
-------

For man pages, see their own description.

For this script, GPL.
