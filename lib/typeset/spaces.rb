module Typeset
  def self.spaces(text, options)
    # replaces wide spaces with hair spaces
    text.gsub!(" / ", "\u2009/\u2009")
    text.gsub!(" × ", "\u2009×\u2009")

    return text
  end
end
