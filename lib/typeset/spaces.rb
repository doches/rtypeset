module Typeset
  # Replace wide (normal) spaces around math operators with hair spaces.
  def self.spaces(text, options)
    text.gsub!(" / ", "\u2009/\u2009")
    text.gsub!(" × ", "\u2009×\u2009")
    text.gsub!(" % ", "\u2009%\u2009")
    text.gsub!(" + ", "\u2009+\u2009")

    return text
  end
end
