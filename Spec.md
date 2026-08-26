## Instructions

Steps:
instructions are grouped and separated by a double newline.

## Python Instructions


python code rules:
- indent is 4 spaces
- line length = 120
- run the code through `ruff format`


## App instructions

### Skeleton


Make a python tkinter app.
With a `menu line` at the top and a `status line` at the bottom.
With a `content frame` between the menu and the status line.
The `content frame` has a scrollable `text window` on the right.
By default color of the text is `black` and color of the background is `white`.
The `content frame` has a scrollable `tree list` on the left.
The `content frame` has a scrollable `tree list` on the right.


In the `menu line` add a Files item to open json files:
   example flow (Menu -> Files -> Open -> 'file selector for *.json').


When a json file is opened,
parse the json like `jq -r .` would do to produce a formatted text for human consumption.
Store the ouput of jq in a list line by line `current_json: list[str]` for later references by line.


When calling the app with a argument --file=<path to json file> process that file direct.
When the  file does not end in '.json' display a warning and ignore the file.
When the file ends in '.json' add it to the list of recent files opened.


When the file is larger then 1 MB show a "Please be patient ... Processing a large file" message
until the procesing has finished.


When possible show a percentage or the processing steps being executed.


When opening files remember the last 25 files opened using their absolute path.
Use a hidden directory in the HOME directory of the user with the name of the app
(so basename argv[0] without the py extension),
and create a list of recently opened files there.


### DATA Processing

#### Generic Json

From `current_json` remember all lines with dict key "status": (status_lines: dict[str, list[int]]).
Show the `current_json` in the `text window` line by line.


Make the json data in the `text window` collapable on each '{', '}' and '[', ']',
except for empty lists or empty dicts.

Above the `text window`
show the path to the current selected line (as breadcrumbs)
where each path element is clickable
and moves the `text window` to that position.
Make it horizontally scollable when the data is too large.


#### HAVING status fields

In the `text window`:
Starting from each `"status": "pass"` color all items that are not list values or dict values in the same block `green`.
Starting from each `"status": "warning"`color all items that are not list values or dict values in the same block `orange`.
Starting from each `"status": "fail"` color all items that are not list values or dict values in the same block `red`.
In case of conflict coloring 'fail' has a higher priority then any other color applied and 'warning' only overrides 'pass'.
With the enclosing block colored,
from the block just colored, travel up the json tree,
and color each dict `key` leading to this color also in the same color
but only the dict `key`.


Remember the json path to each "status" field with the values 'pass', 'warning', 'fail'
and show the path in the `left tree list `.
In `green` for status `pass`,
In `orange` for status `warning`,
In `red` for status `fail`.
When selecting a path in the `left tree list`
expand and show the corresponing item in the `text window` with that path.


Use a `left tree list` to simplefy the list data.
Make a search entry above the `left list window`.
Limit the data shown in the `left list` based on the search pattern in the search entry.
If the left tree is empty minimize the frame holding the `left tree list`.


When selecting a line in the `text window`
see if the `json path` to the line or the enclosing block can be found in the `left tree list`
if so position the current selection in the tree list accordingly,
if not try the blocks above until you find a match.
When the item in the `left tree list` is currently hidden due to folding,
unfold the components required to make it visible.


#### Right side matching string search


Make a `right tree list` at the right side of the `text window`.
When selecting a word enclosed in quotes in the `text window`,
find all other lines containing the same text in the json data and show the paths of those items,
including the path of the search item,
as a tree on the `right tree list`.


The selected line in both tree lists should be a light gray,
and the word highlighted should keep the color it had before the highlight.


#### report.rl.json rules


By default in the `text window`,
collapse the "component" and "references" list
but not the "components" dict.


For each component in report.metadata.components.<component_uuid> that has a color applied in the `text window`,
find the same `component_uuid` anywhere in the `text window` and color it with the same color.


For each violation in report.metadata.violations.<violation_uuid> find the color of its `rule_id`,
then find any other mention of that rule_id in the text and color it the same way.
Rule_id's are string only and uniq for each <violation_uuid>.


For each item colored remember the position of the origin status json path and when hovering over the colored item show the paths to the origin 'status' field that contributed to its coloring.

Make sure to always refer to true line numbers as from `current_json`.
