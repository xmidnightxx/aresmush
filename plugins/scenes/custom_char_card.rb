module AresMUSH
  module Scenes
    def self.custom_char_card_fields(char, viewer)
  {
     traits: Website.format_markdown_for_html(char.traits)
  }
end
 end
end
