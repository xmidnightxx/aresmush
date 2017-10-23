module AresMUSH
  module Login
    class CharConnectedEventHandler
      def on_event(event)
        client = event.client
<<<<<<< HEAD
        char = Character[event.char_id]
=======
        char = event.char
<<<<<<< HEAD
=======
        Global.logger.info("Character Connected: #{char.name}")
>>>>>>> parent of f74f1de2... Merge remote-tracking branch 'upstream/master'
>>>>>>> f4c65b68ee0ea5d11c5138bd391a3246bd32752b
        
        first_login = !char.last_ip
        Login.update_site_info(client, char)

        Global.logger.info("Character Connected: #{char.name} #{char.last_ip} #{char.last_hostname}")
        
        if (first_login)
          Login.check_for_suspect(char)
        end
        
        Global.client_monitor.logged_in.each do |other_client, other_char|
          if (other_char.room == char.room)
            other_client.emit_success t('login.announce_char_connected_here', :name => char.name)
          elsif (Login.wants_announce(other_char, char))
            other_client.emit_ooc t('login.announce_char_connected', :name => char.name)
          end
        end
        
        Global.dispatcher.queue_timer(1, "Login notices", client) do 
          template = NoticesTemplate.new(char)
          client.emit template.render
        end
      end
    end
  end
end
