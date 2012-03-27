Odin
====

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=benjaminoakes&url=https://github.com/benjaminoakes/odin&title=Odin&language=en_GB&tags=github&category=software)

![Odin Esper from Final Fantasy VI](https://github.com/benjaminoakes/odin/raw/master/images/odin-ff6.gif)

![Still Maintained?](http://stillmaintained.com/benjaminoakes/odin.png)
![Build Status](http://travis-ci.org/benjaminoakes/odin.png)

Odin is an **ATN** (Augmented Transition Network) based parser for natural languages with basic part of speech tagging and word-sense disambiguation. Currently, the only supported language is English, but other languages can be added.

Please also see [Raiden][], my simpler, easier-to-understand reimplementation of Odin.

  [raiden]: https://github.com/benjaminoakes/raiden

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

I'm not actively developing Odin right now, but if you have a use for it and you'd like to be a maintainer, please let me know.

You can run unit and functional tests with `rake test`.

Resources
---------

The design of the `AugmentedTransitionNetwork` class was inspired by Paul Graham's implementation in Lisp.  For details on his implementation, please see the full text of his book [_On Lisp_][onlisp] (pages 309 - 320).

Also, there's a diagram of the ATN being used in `images/atn_diagram.pdf`.

  [onlisp]: http://www.paulgraham.com/onlisptext.html

License
-------

Please see the `LICENSE.md` file.
