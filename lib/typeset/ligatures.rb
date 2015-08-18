module Typeset
  # Map of raw text sequences to unicode ligatures
  Ligatures = {
    'ffi' => 'ﬃ',
    'ffl' => 'ﬄ',
    'fi' => 'ﬁ',
    'fl' => 'ﬂ',
    'st' => 'ﬆ',
    'ff' => 'ﬀ',
    'ue' => 'ᵫ'
  }

  # List of ligatures to process by default
  DefaultLigatures = %w{ffi ffl fi fl ff}

  # Find and replace sequences of text with their unicode ligature equivalents.
  # Override the set of ligatures to find by passing in a custom options hash, e.g.:
  #
  #     Typeset.typeset("flue", {:ligatures => ["fl", "ue"]})
  #     # -> returns "ﬂᵫ"
  def self.ligatures(text, options)
    options[:ligatures] ||= DefaultLigatures

    options[:ligatures].each do |ligature|
      text.gsub!(ligature, Ligatures[ligature])
    end

    return text
  end
end
