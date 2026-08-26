# json-coloring-app.py

## APP

Claude genrated app from [Spec.md](./Spec.md)

The app uses python tkinter.

It reads a json file.

When the json contains lines like `"status": <value>`,
where value is one of 'pass', 'warning', 'fail' apply coloring
and populate a search tree on the left.

Any string selected in the central text window
populates the location of similar strings in the entire json
on the right tree window.

## Current coloring scheme:

background is white

default color is black.

status coloring:

- fail = red,
- warning is orange,
- pass is green,
