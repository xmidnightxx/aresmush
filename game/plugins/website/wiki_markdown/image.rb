module AresMUSH
  module Website
    class ImageMarkdownExtension
      def self.regex
        /\[\[image ([^\]]*)\]\]/i
      end
      
      def self.parse(matches, sinatra)
        input = matches[1]
        return "" if !input
        
        style = ""
        source = ""
        align = nil
        options = input.split(' ')
        options.each do |opt|
          option_name = opt.before('=') || ""
          option_value = opt.after('=') || ""
        
          case option_name.downcase.strip
          when 'width'
            style << " width:#{option_value};"
          when 'height'
            style << " height:#{option_value};"
          when 'center', 'left', 'right'
            align = opt.strip
          when 'source', 'src'
            source = option_value.strip
          else
            source = opt.strip
          end
        end
      
<<<<<<< HEAD
=======
        source = source.downcase.strip
        if (!source.start_with?('/files'))
          source = "/files/#{source}"
        end
        
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
        sinatra.erb :"image", :locals => {
          source: source,
          style: style, 
          align: align
          }, :layout => false
      end
    end
  end
end
