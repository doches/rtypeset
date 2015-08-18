require 'typeset/quotes'
require 'typeset/hyphenate'
require 'typeset/ligatures'
require 'typeset/small_caps'
require 'typeset/punctuation'
require 'typeset/hanging_punctuation'
require 'typeset/spaces'
require 'nokogiri'

# Contains all of our typeset-related class methods. Mix this module into a
# class, or just call `Typeset#typset` directly
module Typeset
  # Parse an HTML fragment with Nokogiri and apply a function to all of the
  # descendant text nodes
  def self.apply_to_text_nodes(html, &func)
    doc = Nokogiri::HTML("<div id='rtypeset_internal'>#{html}</div>", nil,"UTF-8",Nokogiri::XML::ParseOptions::NOENT)
    doc.search('//text()').each do |node|
      old_content = node.content
      new_content = func.call(node.content.strip)
      if old_content =~ /^(\s+)/
        new_content = " #{new_content}"
      end
      if old_content =~ /(\s+)$/
        new_content = "#{new_content} "
      end
      node.replace(new_content)
    end
    content = doc.css("#rtypeset_internal")[0].children.map { |child| child.to_html }
    return content.join("")
  end

  # The default typesetting methods and their configuration. Add new methods here
  # in whatever order makes sense.
  DefaultMethods = [
    [:quotes, true],
    [:hanging_punctuation, true],
    [:spaces, true],
    [:small_caps, true],
    [:hyphenate, true],
    [:ligatures, false],
    [:punctuation, false]
  ]

  # The main entry point for Typeset. Pass in raw HTML or text, along with an
  # optional options block.
  def self.typeset(html, options={})
    methods = Typeset::DefaultMethods
    options[:disable] ||= []
    methods.reject! { |method| options[:disable].include?(method[0]) }

    methods.each do |func, use_text_nodes|
      new_html = html
      if use_text_nodes
        new_html = Typeset.apply_to_text_nodes(html) { |content| Typeset.send(func, content, options) }
      else
        new_html = Typeset.send(func, html, options).strip
      end
      html = new_html
    end
    return html
  end
end
