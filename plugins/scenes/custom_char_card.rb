module AresMUSH
  module Scenes
    def self.custom_char_card_fields(char, viewer)
       # This sets a temporary variable named 'traits' with
       # includes the name and description
       traits=(char.traits || {}).map { |k, v| {name: k, description: Website.format_markdown_for_html(v)}}
       {traits: traits}
    end
  end
end
