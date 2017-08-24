module AresMUSH
  module Who
    # Fields used in the who/where templates that relate to displaying
    # a particular character's info
    module WhoCharacterFields
     
      def status_color(char)
        Status.status_color(status(char))
      end
      
      def status(char)
        char.status
      end
   
      def faction(char)
        char.group("Faction")
      end

      def position(char)
        char.group("Position")
      end

      def crew(char)
        char.group("Crew")
      end

      def rank(char)
        char.rank
      end
      
      def idle(char)
        TimeFormatter.format(char.client.idle_secs)
      end   

      def connected(char)
        TimeFormatter.format(char.client.connected_secs)
      end   

      def room(char)
        Who.who_room_name(char)
      end 
      
      def handle(char)
        char.handle ? "@#{char.handle.name}" : ""
      end
    end
  end
end