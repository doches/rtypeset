require 'helper'

class TestTypeset < Minitest::Test
  Lorem = "Lorem ipsum dolor, sit <em class=\"latin\">amet</em>"
  OptNoHyphenate = {:disable => [:hyphenate]}

  def setup
    assert_equal Lorem, Typeset.typeset(Lorem, OptNoHyphenate)
  end

  def test_quotes
    assert_equal "“foo”", Typeset.typeset("\"foo\"", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "foo”", Typeset.typeset("foo\"", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "foo’s bar", Typeset.typeset("foo's bar", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "’foo", Typeset.typeset("'foo", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "foo’", Typeset.typeset("foo'", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "’93", Typeset.typeset("'93", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "19′ 43.5″", Typeset.typeset("19\' 43.5\"")
  end

  def test_spaces
    assert_equal "1\u2009/\u20092", Typeset.typeset("1 / 2")
    assert_equal "1\u2009×\u20092", Typeset.typeset("1 × 2")
  end

  def test_punctuation
    assert_equal "…", Typeset.typeset("...")
    assert_equal "foo–bar", Typeset.typeset("foo--bar")
    assert_equal "foo\u2009–\u2009bar", Typeset.typeset("foo -- bar")

    assert_equal "¿&nbsp;foo&nbsp;?", Typeset.typeset("¿ foo ?", OptNoHyphenate)
    assert_equal "bar [&nbsp;foo&nbsp;] baz", Typeset.typeset("bar [ foo ] baz", OptNoHyphenate)
  end

  def test_small_caps
    assert_equal "an <span class=\"small-caps\">FBI</span> agent", Typeset.typeset("an FBI agent", OptNoHyphenate)
    assert_equal "The <span class=\"small-caps\">CIA</span>", Typeset.typeset("The CIA", {:disable => [:hanging_punctuation, :hyphenate]})
    assert_equal "<span class=\"small-caps\">NCSA</span>", Typeset.typeset("NCSA", OptNoHyphenate)
    assert_equal "<span class=\"small-caps\">NCSA</span> Mosaic", Typeset.typeset("NCSA Mosaic", OptNoHyphenate)
    assert_equal "developed by <span class=\"small-caps\">NCSA</span>.", Typeset.typeset("developed by NCSA.", OptNoHyphenate)
    assert_equal "mCAT", Typeset.typeset("mCAT", OptNoHyphenate)
    assert_equal "<span class=\"small-caps\">CAT</span>-5", Typeset.typeset("CAT-5", {:disable => [:hanging_punctuation, :hyphenate]})
  end

  def test_hanging
    assert_equal "<span class=\"pull-false\">Y</span>early<span class=\"push-Y\"></span>", Typeset.typeset("Yearly", OptNoHyphenate)
  end

  def test_ligatures
    assert_equal "ﬀoo", Typeset.typeset("ffoo")
    assert_equal "ﬁoo", Typeset.typeset("fioo")
    assert_equal "ﬂoo", Typeset.typeset("floo")
    assert_equal "ﬃoo", Typeset.typeset("ffioo")
    assert_equal "ﬄoo", Typeset.typeset("ffloo")

    # Ensure extended ligatures don't work by default...
    assert_equal "ﬂue", Typeset.typeset("flue")
    assert_equal "due", Typeset.typeset("due")

    # ...but do work on request
    assert_equal "ﬆoo", Typeset.typeset("stoo", {:ligatures => [Typeset::DefaultLigatures, 'st'].flatten})
    assert_equal "ᵫoo", Typeset.typeset("ueoo", {:ligatures => [Typeset::DefaultLigatures, 'ue'].flatten})
  end

  def test_hyphenate
    assert_equal "do hy\u00ADphen\u00ADation", Typeset.typeset("do hyphenation", Typeset::DefaultOptions)
  end
end
