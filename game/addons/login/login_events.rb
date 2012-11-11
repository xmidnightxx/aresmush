module AresMUSH
  module Login
    class LoginEvents
      def on_registered
        @client_monitor = container.client_monitor
      end
      
      def on_player_connected(args)
        client = args[:client]
        @client_monitor.tell_all t('login.player_has_connected', :name => client.id)
      end

      def on_player_disconnected(args)
        client = args[:client]
        @client_monitor.tell_all t('login.player_has_disconnected', :name => client.id)
      end
      
      include AresMUSH::Addon
    end
  end
end
