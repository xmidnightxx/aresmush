module AresMUSH
  module Website
    class WikidotExternalLinkMarkdownExtension
      def self.regex
<<<<<<< HEAD
        /[^`]\[http([^\] ]*) ([^\]]*)\]/i
=======
        /\[http([^\] ]*) ([^\]]*)\]/i
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
      end
      
      def self.parse(matches, sinatra)
        url = matches[1]
        link_text = matches[2]

        return "" if !url || !link_text

        "[#{link_text}](http#{url})"
      end
    end
    
<<<<<<< HEAD
=======
    class WikidotHtml
      def self.regex
        /\[\[\/?html\]\]/i
      end
      
      def self.parse(matches, sinatra)
        ""
      end
    end
    
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
    class WikidotInternalLinkMarkdownExtension
      def self.regex
        /\[\[\[([^\]]*)\]\]\]/i
      end
      
      def self.parse(matches, sinatra)
        text = matches[1]
        return "" if !text

        if (text =~ /\|/)
          url = text.before('|')
          link = text.after('|')
        else
          url = text
          link = text
        end
        
        if (link =~ /:/)
          link = link.after(":")
        end
        
        url = url.downcase.gsub(' ', '-')
        if (url.start_with?("char:"))
          "<a href=\"/char/#{url.after(':')}\">#{link}</a>"
        else
          "<a href=\"/wiki/#{url}\">#{link}</a>"
        end
      end
    end
    
    class WikidotItalics
      def self.regex
       /\/\/([^\/\r\n]+)\/\//
      end
      
      def self.parse(matches, sinatra)
        text = matches[1]
        return "" if !text

        "<em>#{text}</em>"
      end
    end
    
    class WikidotHeading
      def self.regex
       /^([\+]+) /
      end
      
      def self.parse(matches, sinatra)
        heading = matches[1]
        return "" if !heading

        "##{heading.gsub("+", "#")} "
      end
    end
    
<<<<<<< HEAD
=======
    class WikidotCenter
      def self.regex
        /\[\[=\]\]/
      end
      
      def self.parse(matches, sinatra)
        "[[div class=\"centered\"]]"
      end
    end
    
    class WikidotEndCenter
      def self.regex
       /\[\[\/=\]\]/
      end
      
      def self.parse(matches, sinatra)
        "[[/div]]"
      end
    end
    
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
    class WikidotAnchor
      def self.regex
        /^\[\[#(.+)\]\]/i
      end
      
      def self.parse(matches, sinatra)
        url = matches[1]
        return "" if !url

        "<a name=\"#{url.downcase.strip}\"></a>"
      end
    end    
  end
end