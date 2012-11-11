module AresMUSH
  module Pose
    class Say
      def on_registered
        @client_monitor = container.client_monitor
      end
      
      def commands
        ["say (?<msg>.+)", "\"(?<msg>.+)"]
      end
      
      def on_player_command(client, cmd)
        @client_monitor.tell_all "Client #{client.id} says \"#{cmd[:msg]}\""
      end
      
      include AresMUSH::Addon      
    end
  end
end
