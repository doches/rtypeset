module Typeset
  module HangingPunctuation
    DoubleWidth = ['&quot;', '"', "“", "„", "”", "&ldquo;", "&OpenCurlyDoubleQuote;", "&#8220;", "&#x0201C;", "&rdquor;", "&rdquo;", '&CloseCurlyDoubleQuote;', '&#8221;', '&ldquor;', '&bdquo;', '&#8222;']
    SingleWidth = ["'", '&prime;', '&apos;', '&lsquo;', '&rsquo;', '‘', '’']

    def self.pull(classname, content='')
      HangingPunctuation.wrap("pull", classname, content)
    end

    def self.push(classname, content='')
      HangingPunctuation.wrap("push", classname, content)
    end

    def self.wrap(type, classname, content='')
      "<span class=\"#{type}-#{classname}\">#{content}</span>"
    end
  end

  def self.hanging_punctuation(text, options)
    return text if text.length < 2

    aligns = "CcOoYTAVvWwY".split('')
    words = text.split(/\s+/)
    words.each_with_index do |word, i|
      aligns.each do |align|
        if word[0] == align
          words[i] = "#{HangingPunctuation.pull(align, align)}#{word.slice(1,word.length)}"

          if not words[i-1].nil?
            words[i-1] = "#{words[i-1]}#{HangingPunctuation.push(align)}"
          end
        end
      end
      HangingPunctuation::SingleWidth.each do |punctuation|
        if word[0] == punctuation
          words[i] = "#{HangingPunctuation.pull('single', punctuation)}#{word.slice(1,word.length)}"

          if not words[i-1].nil?
            words[i-1] = "#{words[i-1]}#{HangingPunctuation.push('single')}"
          end
        end
      end
      HangingPunctuation::DoubleWidth.each do |punctuation|
        if word[0] == punctuation
          words[i] = "#{HangingPunctuation.pull('double', punctuation)}#{word.slice(1,word.length)}"

          if not words[i-1].nil?
            words[i-1] = "#{words[i-1]}#{HangingPunctuation.push('double')}"
          end
        end
      end
    end

    return words.join(" ")
  end
end
