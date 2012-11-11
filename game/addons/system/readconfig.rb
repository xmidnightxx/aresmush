module AresMUSH
  module System
    class ReadConfig
      def on_registered
        @client_monitor = container.client_monitor
        @config_reader = container.config_reader
      end

      def commands
        ["readconfig"]
      end

      def on_player_command(client, cmd)
        @config_reader.read
        client.emit_success "You reload the config files."
      end
      
      include AresMUSH::Addon      
    end
  end
end
