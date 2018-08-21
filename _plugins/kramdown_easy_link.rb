module Kramdown
  module Parser

    # Standard Kramdown parser extends auto link.
    #
    # This class extends the default Kramdown syntax with a new span-level
    # element for embedding `http://example.com`. The element is rendered
    # as a `<a href="http://example.com">http://example.com</a>`.
    #
    # Original repository: https://github.com/shoyan/kramdown_easy_link
    #
    # @author Shohei Yamasaki, modified by Andrew Makousky
    class KramdownEasyLink < ::Kramdown::Parser::GFM

      def initialize(source, options)
        super
        @span_parsers.unshift(:easy_link)
      end

      EASY_LINK_START = /(https?:\/\/[\S\.]+)/

      # Do not use this method directly, it's used internally by Kramdown.
      # @api private
      def parse_easy_link
        @src.pos += @src.matched_size
        url = @src[1]
        @tree.children << Element.new(:easy_link, url)
      end
      define_parser(:easy_link, EASY_LINK_START)
    end
  end
end

module Kramdown
  module Converter
    class Html
      # Convert a started http string into a `<a>` tag suitable for embedding.
      #
      # @return [String] an HTML fragment representing this element
      # @api private
      def convert_easy_link(el, indent)
        "<a href=\"#{el.value}\">#{el.value}</a>"
      end
    end
  end
end
