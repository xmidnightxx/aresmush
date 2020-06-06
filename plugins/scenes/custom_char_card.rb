module AresMUSH
  module Scenes
    def self.custom_char_card_fields(char, viewer)
  {
     hooks: Website.format_markdown_for_html(char.rp_hooks)
  }

    end
  end
end
