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
        if char.has_any_role?([ "admin", "staff", "gm", "builder" ]) then "%cmStaff%cn"
          elsif !char.is_approved? then char.group("Position")
          elsif char.group("Position").nil? || char.group("Position").empty? then "%chN/A%cn"
          else char.group("Position")
        end
      end

      def crew(char)
        char_crew = char.group("Crew")
        if char.has_any_role?([ "admin", "staff", "gm", "builder" ]) then "%cmStaff%cn"
          elsif !char.is_approved? then char_crew
          elsif char_crew.nil? || char_crew.empty? then "%ccShore%cn"
          else 
           case char_crew
            when "Reaver"
              "%x8Reaver%cn"
            when "Impudent"
              "%ch%crImpudent%cn"
            when "Santiago"
              "%ch%cySantiago%cn"
            when "Shore"
              "%ccShore%cn"
            else
              char_crew
           end
        end
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