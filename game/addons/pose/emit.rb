module AresMUSH
  module Pose
    class Emit
      def on_registered
        @client_monitor = container.client_monitor
      end
      
      def commands
        ["emit (?<msg>.+)", "\\\\(?<msg>.+)"]
      end
      
      def on_player_command(client, cmd)
        @client_monitor.tell_all "#{cmd[:msg]}"
      end
      
      include AresMUSH::Addon      
    end
  end
end
