module AresMUSH
  module Pose
    class Whisper
      def on_registered
        @client_monitor = container.client_monitor
      end
      
      def commands
        ["whisper (?<msg>.+)", "\\\\(?<msg>.+)"]
      end
      
      def on_player_command(client, cmd)
        @client_monitor.tell_all "whisper #{cmd[:msg]}"
      end
      
      include AresMUSH::Addon      
    end
  end
end
