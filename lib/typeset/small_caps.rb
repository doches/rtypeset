module Typeset
  # Holds convenience methods for acronym detection
  module SmallCaps
    def self.remove_cruft(word)
      trailing = ""
      leading = ""

      if word =~ /([A-Z][A-Z][A-Z]+)/
        leading,word,trailing = word.split($1)
      end

      return [leading, word, trailing]
    end
  end

  # Identify likely acronyms, and wrap them in a 'small-caps' span.
  def self.small_caps(text, options)
    words = text.split(" ")
    words.each_with_index do |word, i|
      if word =~ /^\W*([[:upper:]][[:upper:]][[:upper:]]+)\W*/
        leading,trailing = word.split($1)
        words[i] = "#{leading}<span class=\"small-caps\">#{$1}</span>#{trailing}"
      end
    end
    return words.map { |x| x.strip }.join(" ")
  end
end
