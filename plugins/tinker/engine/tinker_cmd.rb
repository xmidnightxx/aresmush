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
        Character.all.each do |c|
          if (c.room_id == null)
          #c.update(room_id: 3)
          Client.emit_raw c
          end
        end
      end

    end
  end
end
