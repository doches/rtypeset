require 'text/hyphen'

module Typeset
  # Hyphenate text, inserting soft hyphenation markers. Specify the language
  # for hyphenation by passing in an options block to your typeset call, e.g.:
  #
  #     Typeset.typeset("do hyphenation on this", {:language => "en_gb"})
  def self.hyphenate(text, options)
    options[:language] ||= 'en_us'
    hyphen = Text::Hyphen.new(:language => options[:language], :left => 0, :right => 0)

    text = hyphen.visualise(text, "\u00AD")

    return text
  end
end
