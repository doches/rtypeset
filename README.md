# An HTML pre-processor for web typography

[![Gem Version](https://badge.fury.io/rb/rtypeset.svg)](http://badge.fury.io/rb/rtypeset)
[![Build Status](https://travis-ci.org/doches/rtypeset.png)](https://travis-ci.org/doches/rtypeset)
[![Documentation Status](https://inch-ci.org/github/doches/rtypeset.svg)](https://inch-ci.org/github/doches/rtypeset)
[![Code Climate](https://codeclimate.com/github/doches/rtypeset/badges/gpa.svg)](https://codeclimate.com/github/doches/rtypeset)
[![Test Coverage](https://codeclimate.com/github/doches/rtypeset/badges/coverage.svg)](https://codeclimate.com/github/doches/rtypeset/coverage)

A pure Ruby typographic pre-processor for HTML inspired by [Typeset.js](https://github.com/davidmerfield/Typeset) that gives you:

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

    raw_html = <<HTM
    <p>Yjarni Sigurðardóttir spoke to NATO from Iceland yesterday:
    "Light of my life, fire of my florins -- my sin, my soul.
    The tip of the tongue taking a trip to 118° 19' 43.5".":</p>
    HTM

    # Output beautifully-formatted HTML
    puts Typeset.typeset(raw_html)

### Customisation

Want more control over your typesetting? 

#### Disabling Features

You can selectively disable Typeset features by passing in an options hash to `#typeset`:

    # Disable hyphenation and small caps conversion.
    options = {:disable => [:hyphenate, :small-caps]}
    Typeset.typeset(raw_html, options)

The full list of modules is: `:quotes`, `:hanging_punctuation`, `:spaces`, `:small_caps`, `:hyphenate`, `:ligatures` and `:punctuation`.

#### Hyphenation Language

If you're using hyphenation (it's on by default!) you may want to specify the language (the default is `en_us`):

    Typeset.typeset(raw_html, {:language => "en_us"})