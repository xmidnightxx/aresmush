module AresMUSH
  module Page
    class SendPageRequestHandler
      def handle(request)
        enactor = request.enactor
        
        if (!enactor)
          return { error: t('webportal.login_required') }
        end
        
        error = Website.check_login(request)
        return error if error
         
        Page.send_page               
        {}
      end
    end
  end
end


