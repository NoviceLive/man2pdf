# man2pdf

## Usage

```
./man2pdf path-to-man-pages-directory
```

where the `path-to-man-pages-directory`
is the root directory of the decompressed man-pages release,
which is available at
[The Linux man-pages project](https://www.kernel.org/doc/man-pages/).

## Output

Eight manuals in PDF format, and one 32.pdf and a 64.pdf.

Note _pdf is merely a temporay directory.

## Dependencies

- pdfroff, which comes from the package groff

- [pdfbookmark](https://github.com/NoviceLive/pdfbookmark), I wrote

## NOTE

For those who just want the generated PDFs,
you had better clone with `--depth 1`.

## TODO
