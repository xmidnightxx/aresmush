module AresMUSH
  module Scenes
    def self.custom_char_card_fields(char, viewer)
  {
    traits = (char.traits || {}).map { |k, v| {name: k, description: v }
  }
  {
    char.traits.map => traits
  }
    end
  end
end
