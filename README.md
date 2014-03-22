pianochords
===========

Generator for an Anki deck to learn Jazz piano chord layouts

## Overview

This might be handy if you learn Jazz piano and want to memorize
chords in order to be able to read lead sheets.

You can use this program to generate an [Anki deck](http://ankisrs.net/)
containing basic question/answer pairs as follows:

![sample question answer pair](/example.png "A sample question/answer pair")

Various chord types are supported (e.g. maj7, dominant 7th, minor 7th, halfdiminished,
diminished) as are different inversions (to the right of the chord symbol
is a circled number, representing the topmost chord interval).

## Usage
### For the impatient
There's a pre-generated deck available. Just download
`pianochords_ankideck.tgz` and [import it in Anki](http://ankisrs.net/docs/manual.html#importing).
Make sure you follow the advise in [Anki's section on Importing
Media](http://ankisrs.net/docs/manual.html#importing-media).

### Using the generator
Run

    bin/pianochords help generate

for an overview of options.

For a start, try

    bin/pianochords generate -r c

## Prerequisites
You need LaTeX with the [piano.sty](http://www.ctan.org/tex-archive/macros/latex/contrib/piano).
And Ruby, of course. I used Ruby 1.9.3 and Ruby 2.0 during development.

## Development
Start reading `bin/pianochords`, or skip directly to `lib/anki_chord_generator.rb` and descend from there.

Run the tests with `rake test`

## Remarks and open issues
* Currently, there is no usable command line functionality. To generate a
  deck, one has to run the `tc_anki_generator` test, in particular the
  `test_generate_all` method.
* The code internally uses a mixture of English and German musical
  terminology, and the file names of the generated PNGs reflect that, too.
* I recommend to patch `piano.sty` and modify the picture dimensions
  from `\begin{picture}(14,4.5)` to `\begin{picture}(13.9,4.05)` in order to
  get rid of unwanted borders (and therefore incorrect centering).
