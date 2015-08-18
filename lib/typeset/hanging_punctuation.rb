module Typeset
  # Contains constants and methods specific to our hanging punctuation implementation
  module HangingPunctuation
    # Characters that need a double-width pull
    DoubleWidth = ['&quot;', '"', "“", "„", "”", "&ldquo;", "&OpenCurlyDoubleQuote;", "&#8220;", "&#x0201C;", "&rdquor;", "&rdquo;", '&CloseCurlyDoubleQuote;', '&#8221;', '&ldquor;', '&bdquo;', '&#8222;']
    # Characters that need a single-width pull
    SingleWidth = ["'", '&prime;', '&apos;', '&lsquo;', '&rsquo;', '‘', '’']

    # Wrap a piece of content in a pull class
    def self.pull(classname, content='')
      HangingPunctuation.wrap("pull", classname, content)
    end

    # Wrap a piece of content in a push class
    def self.push(classname, content='')
      HangingPunctuation.wrap("push", classname, content)
    end

    # Wrap a piece of content in an arbitrary class. Convenience method for
    # implementing #push and #pull
    def self.wrap(type, classname, content='')
      "<span class=\"#{type}-#{classname}\">#{content}</span>"
    end
  end

  # Add push/pull spans for hanging punctuation to text.
  def self.hanging_punctuation(text, options)
    return text if text.length < 2

    aligns = "CcOoYTAVvWwY".split('')
    words = text.split(/\s+/)
    words.each_with_index do |word, i|
      [[aligns, false],
       [HangingPunctuation::SingleWidth, 'single'],
       [HangingPunctuation::DoubleWidth, 'double']].each do |pair|
        pair[0].each do |signal|
          if word[0] == signal
            words[i] = "#{HangingPunctuation.pull(pair[1], signal)}#{word.slice(1,word.length)}"

            if not words[i-1].nil?
              words[i-1] = "#{words[i-1]}#{HangingPunctuation.push(pair[1] ? pair[1] : signal)}"
            end
          end
        end
      end
    end

    return words.join(" ")
  end
end
