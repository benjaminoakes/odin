Odin
====

![Odin Esper from Final Fantasy VI](https://github.com/benjaminoakes/odin/raw/master/images/odin-ff6.gif)

Odin is an **ATN** (Augmented Transition Network) based parser for natural languages with basic part of speech tagging and word-sense disambiguation. Currently, the only supported language is English, but other languages can be added.

If interested, please become a watcher.

Usage
-----

    ruby check_grammar.rb file_name

Output is saved to `file_name.checked.html`.  There are some test files in "test/fixtures/".

History
-------

This is based on a project I made for a Computational Linguistics course at the University of Iowa (taught by now-retired [Professor Oden][oden], hence the name) back in 2007.  It's not the earliest "serious" Ruby code I've written, but it's pretty close.

  [oden]: http://cs.uiowa.edu/~oden

Contributing
------------

You can run unit and functional tests with `rake test`.

Resources
---------

The design of the `AugmentedTransitionNetwork` class was inspired by Paul Graham's implementation in Lisp.  For details on his implementation, please see the full text of his book [_On Lisp_][onlisp] (pages 309 - 320).

Also, there's a diagram of the ATN being used in `images/atn_diagram.pdf`.

  [onlisp]: http://www.paulgraham.com/onlisptext.html

License
-------

Please see the `LICENSE.md` file.
