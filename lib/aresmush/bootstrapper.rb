module AresMUSH  
  class Bootstrapper 
    
    def boot
      ares_logger = AresLogger.new
      locale = Locale.new
      db = Database.new
      
      # Set up global access to the system objects - primarily so that the plugins can 
      # tell them to do things.
      Global.locale = locale
                  
      # Configure a trap for exiting.
      at_exit do
        handle_exit($!)
      end
      
      # Order here is important!
      ares_logger.start

      db.load_config
      locale.setup
            
      begin
        game = Game.master
      rescue Exception => e
        raise "Error connecting to database. Check your database configuration: #{e}"
      end
      
      server = Server.new#("localhost", 7206)
      server.start
      
      #Rack::Builder.new { AresWeb.run! }.to_app

    end
      
    def handle_exit(exception)
      if (exception.kind_of?(SystemExit))
        Global.logger.info "Normal shutdown."
      elsif (exception.nil?)
        Global.logger.info "Shutting down."
      else
        Global.logger.fatal "Abnormal shutdown.  \nLast exception: (#{exception.inspect})\nBacktrace: \n#{exception.backtrace[0,10]}"
      end
    end
    
  end

end