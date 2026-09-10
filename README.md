# jy.py

*renamed after adding yaml support*

## APP

Claude genrated app from [jy_spec.md](./jy_spec.md)

The app uses python tkinter.

It reads a json file or a yaml/yml file.

When the file contains lines like `"status": <value>`,
where value is one of 'pass', 'warning', 'fail' apply coloring
and populate a search tree on the left.

Any json string or yaml key selected in the central text window
populates the location of similar strings in the entire json
on the right tree window.

## Current coloring scheme:

background is white

default color is black.

status coloring:

- fail = red,
- warning is orange,
- pass is green,
