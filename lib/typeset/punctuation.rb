module Typeset
  # Make dashes, elipses, and start/end punctuation a little prettier.
  def self.punctuation(text, options)
    # Dashes
    text.gsub!('--', '–')
    text.gsub!(' – ', "\u2009–\u2009")

    # Elipses
    text.gsub!('...', '…')

    # Non-breaking space for start/end punctuation with spaces.
    start_punc = /([«¿¡\[\(]) /
    if text =~ start_punc
      text.gsub!(start_punc, "#{$1}&nbsp;")
    end
    end_punc = / ([\!\?:;\.,‽»\]\)])/
    if text =~ end_punc
      text.gsub!(end_punc,"&nbsp;#{$1}")
    end

    return text
  end
end
