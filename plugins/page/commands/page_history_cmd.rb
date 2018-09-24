module AresMUSH
  module Page
    class PageHistoryCmd
      include CommandHandler

      attr_accessor :option
      
      def parse_args
        self.option = OnOffOption.new(cmd.args)
      end
      
      def required_args
        [ self.option ]
      end
      
      def check_status
        return self.option.validate
      end
      
      def handle
        enactor.update(page_history_enabled: self.option.is_on?)
        client.emit_success t('page.history_set', :value => self.option)
      end
    end
  end
end
