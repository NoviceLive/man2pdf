# man2pdf

![](screenshot.png)

## Usage

```
./man2pdf.sh path-to-man-pages-directory
```

where the `path-to-man-pages-directory`
is the root directory of the decompressed man-pages release,
which is available at
[The Linux man-pages project](https://www.kernel.org/doc/man-pages/).

[The Linux man-pages project](https://www.kernel.org/doc/man-pages/)

## Output

Eight manuals in PDF format, and one 32.pdf and a 64.pdf.

Note _pdf is merely a temporay directory.

## Dependencies

- pdfroff, which comes from the package groff

- [pdfbookmark](https://github.com/NoviceLive/pdfbookmark), I wrote

## NOTE

You had better clone it with `--depth 1` option.

## TODO

+ Improve the regex because the current is unbearably ugly

## License

For man pages, see their own description.

For this script, GPL.
