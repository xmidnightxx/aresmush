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
        chars = Chargen.approved_chars
        chars.sort_by do |char|
          ClassTargetFinder.with_a_character(char.name, client, enactor) do |model|
            if (!model.is_approved?)
              client.emit_failure t('chargen.not_approved', :name => model.name) 
              return
            end
            
            model.update(is_approved: false)
            model.update(approval_job: nil)
            model.update(chargen_locked: false)   
            client.emit_success t('chargen.app_unapproved', :name => model.name)
          end
         end 
       end
    end
  end
end