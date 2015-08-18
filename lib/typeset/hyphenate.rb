require 'text/hyphen'

module Typeset
  def self.hyphenate(text, options)
    options[:language] ||= 'en_us'
    hyphen = Text::Hyphen.new(:language => options[:language])

    text = hyphen.visualise(text, "\u00AD")

    return text
  end
end
