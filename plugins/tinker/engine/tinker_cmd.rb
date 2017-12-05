module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
            
      def parse_args
      end
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
      def handle
        crews = Demographics.get_group("Crew")
        ranks = []
        ranks << " "
        crews['values'].each do |k, v|
          ranks.concat Ranks.allowed_ranks_for_group(k)
        end
        
        allowed_ranks = Ranks.allowed_ranks_for_group(enactor.group("Crew"))
        
        ranks.each do |k, v|
          client.emit_ooc k
        end
        
        client.emit_ooc allowed_ranks
      
      end

    end
  end
end
