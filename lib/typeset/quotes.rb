module Typeset
  # A poor-man's Smarty Pants implementation. Converts single & double quotes,
  # tick marks, backticks, and primes into prettier unicode equivalents.
  def self.quotes(text, options)
    # Unencode encoded characters, so our regex mess below works
    text.gsub!('&#39;',"\'")
    text.gsub!('&quot;',"\"")

    if text =~ /(\W|^)"(\S+)/
      text.gsub!(/(\W|^)"(\S+)/, "#{$1}\u201c#{$2}") # beginning "
    end
    if text =~ /(\u201c[^"]*)"([^"]*$|[^\u201c"]*\u201c)/
      text.gsub!(/(\u201c[^"]*)"([^"]*$|[^\u201c"]*\u201c)/, "#{$1}\u201d#{$2}") # ending "
    end
    if text =~ /([^0-9])"/
      text.gsub!(/([^0-9])"/, "#{$1}\u201d") # remaining " at end of word
    end
    if text =~ /(\W|^)'(\S)/
      text.gsub!(/(\W|^)'(\S)/, "#{$1}\u2018#{$2}") # beginning '
    end
    if text =~ /([a-z])'([a-z])/i
      text.gsub!(/([a-z])'([a-z])/i, "#{$1}\u2019#{$2}") # conjunction's possession
    end
    if text =~ /((\u2018[^']*)|[a-z])'([^0-9]|$)/i
      text.gsub!(/((\u2018[^']*)|[a-z])'([^0-9]|$)/i, "#{$1}\u2019#{$3}") # ending '
    end
    if text =~ /(\u2018)([0-9]{2}[^\u2019]*)(\u2018([^0-9]|$)|$|\u2019[a-z])/i
      text.gsub!(/(\u2018)([0-9]{2}[^\u2019]*)(\u2018([^0-9]|$)|$|\u2019[a-z])/i, "\u2019#{$2}#{$3}") # abbrev. years like '93
    end
    if text =~ /(\B|^)\u2018(?=([^\u2019]*\u2019\b)*([^\u2019\u2018]*\W[\u2019\u2018]\b|[^\u2019\u2018]*$))/i
      text.gsub!(/(\B|^)\u2018(?=([^\u2019]*\u2019\b)*([^\u2019\u2018]*\W[\u2019\u2018]\b|[^\u2019\u2018]*$))/i, "#{$1}\u2019") # backwards apostrophe
    end
    text.gsub!(/'''/, "\u2034") # triple prime
    text.gsub!(/("|'')/, "\u2033") # double prime
    text.gsub!(/'/, "\u2032")

    # Allow escaped quotes
    text.gsub!('\\\“','\"')
    text.gsub!('\\\”','\"')
    text.gsub!('\\\’','\'')
    text.gsub!('\\\‘','\'')

    return text
  end
end
