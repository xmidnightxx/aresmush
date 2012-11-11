module AresMUSH
  module Login
    class Quit      
      def commands
        ["quit"]
      end
      
      def on_player_command(client, cmd)
        client.disconnect
      end
      
      include AresMUSH::Addon
    end    
  end
end
