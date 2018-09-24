module AresMUSH
  module Page
    class PagesListRequestHandler
      def handle(request)
        enactor = request.enactor
        
        if (!enactor)
          return { error: t('webportal.login_required') }
        end
        
        error = Website.check_login(request)
        return error if error
                
        enactor.page_history.map { |names, messages|
          {
            names: names,
            messages: messages.map { |m| {
               message: Website.format_markdown_for_html(m['message']),
               timestamp: OOCTime.local_long_timestr(enactor, m['timestamp']) }
             }
          }
        }
      end
    end
  end
end


