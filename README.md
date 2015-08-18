# An HTML pre-processor for web typography

[![Build Status](https://travis-ci.org/doches/rtypeset.png)](https://travis-ci.org/doches/rtypeset)
[![Documentation Status](https://inch-ci.org/github/doches/rtypeset.svg?branch=master)](https://inch-ci.org/github/doches/rtypeset)

a pure Ruby typographic pre-processor for HTML inspired by [Typeset.js](https://github.com/davidmerfield/Typeset) that gives you:

    * Real hang­ing punc­tu­a­tion
    * Soft hy­phen in­ser­tion
    * Op­ti­cal mar­gin out­dents
    * Small-caps conversion
    * Punc­tu­a­tion sub­sti­tu­tion
    * Space sub­sti­tu­tion

## Installation

    gem install rtypeset

## Usage

Just require the `typeset` gem and then call `#typeset` to receive beautifully-formatted
HTML:

    require 'typeset'

    raw_html = &lt;&lt;HTM
    &lt;p&gt;Yjarni Sigurðardóttir spoke to NATO from Iceland yesterday:
    "Light of my life, fire of my florins -- my sin, my soul.
    The tip of the tongue taking a trip to 118° 19' 43.5".":&lt;/p&gt;
    HTM

    # Output beautifully-formatted HTML
    puts Typeset.typeset(raw_html)

Want more control over your typesetting? You can selectively disable Typeset features by passing
in an options hash to `#typeset`:

    # Disable hyphenation and small caps conversion.
    options = {:disable => [:hyphenate, :small-caps]}
    Typeset.typeset(raw_html, options)

The full list of disablable modules is: `:quotes`, `:hanging_punctuation`, `:spaces`, `:small_caps`, `:hyphenate`, `:ligatures` and `:punctuation`.
