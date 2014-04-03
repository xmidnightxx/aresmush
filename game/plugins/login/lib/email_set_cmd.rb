module AresMUSH
  module Login
    class EmailSetCmd
      include AresMUSH::Plugin
      
      attr_accessor :email

      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.argument_must_be_present "email", "email"
      end

      def want_command?(client, cmd)
        cmd.root_is?("email") && cmd.switch_is?("set")
      end

      def crack!
        self.email = trim_input(cmd.args)
      end

      def check_email_format
        if self.email !~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
          return t('login.invalid_email_format')
        end
        return nil
      end
      
      def handle        
        client.char.email = self.email
        client.char.save!
        client.emit_success t('login.email_set')
      end
    end
  end
end
