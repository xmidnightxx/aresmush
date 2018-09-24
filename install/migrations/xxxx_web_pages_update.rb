module AresMUSH  
  module Migrations
    class MigrationBeta24Update
      def require_restart
        false
      end
      
      def migrate
        Global.logger.debug "Initializing page history."
        Character.all.each { |c| c.update( page_history: {} )}
        Character.all.each { |c| c.update( page_history_enabled: false )}
      end
    end
  end
end