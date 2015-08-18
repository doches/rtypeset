module Typeset
  Ligatures = {
    'ffi' => 'ﬃ',
    'ffl' => 'ﬄ',
    'fi' => 'ﬁ',
    'fl' => 'ﬂ',
    'st' => 'ﬆ',
    'ff' => 'ﬀ',
    'ue' => 'ᵫ'
  }

  DefaultLigatures = %w{ffi ffl fi fl ff}

  def self.ligatures(text, options)
    options[:ligatures] ||= DefaultLigatures

    options[:ligatures].each do |ligature|
      text.gsub!(ligature, Ligatures[ligature])
    end
    
    return text
  end
end
