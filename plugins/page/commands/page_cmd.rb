module AresMUSH
  module Page
    class PageCmd
      include CommandHandler

      attr_accessor :names, :message
      
      def parse_args
        if (!cmd.args)
          self.names = []
        elsif (cmd.args.start_with?("="))
          self.names = enactor.last_paged
          self.message = cmd.args.after("=")
        elsif (cmd.args.include?("="))
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          
          # Catch the common mistake of last-paging someone a link.
          if (args.arg1 && (args.arg1.include?("http://") || args.arg1.include?("https://")) )
            self.names = enactor.last_paged
            self.message = "#{args.arg1}=#{args.arg2}"
          else
            self.names = list_arg(args.arg1)
            self.message = trim_arg(args.arg2)
          end
        else
          self.names = enactor.last_paged
          self.message = cmd.args
        end
      end
      
      def check_page_target
        return t('page.target_missing') if !self.names || self.names.empty?
        return nil
      end
      
      def handle
        OnlineCharFinder.with_online_chars(self.names, client) do |results|
          recipients = results.map { |result| result.char }
          
          locked = recipients.select { |c| c.page_ignored.include?(enactor) }
          if (locked.any?)
            locked_names = locked.map { |c| c.name }
            client.emit_failure t('page.cant_page_ignored', :names => locked_names.join(" "))
            return
          end
          
          name = enactor.name_and_alias
          message = PoseFormatter.format(name, self.message)
          recipient_names = recipients.map { |r| r.name }.join(",")
        
          client.emit t('page.to_sender', 
          :autospace => enactor.page_autospace, 
          :color => enactor.page_color, 
          :recipients => recipient_names, 
          :message => message)
          results.each do |r|
            Page.page_recipient(enactor, r.client, r.char, recipients, message)
          end
          
          Page.add_to_history(enactor, enactor, recipients, message)
          
          enactor.update(last_paged: self.names)
        end
      end
      
      def page_color
        Global.read_config("page", "page_color")
      end
      
      def log_command
        # Don't log pages
      end
    end
  end
end
