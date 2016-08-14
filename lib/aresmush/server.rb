require 'eventmachine'
require 'em-websocket'
 
module AresMUSH
  class CellServer
    include Celluloid::IO
      finalizer :shutdown

      def initialize(host, port)
        puts "*** Starting echo server on #{host}:#{port}"

        # Since we included Celluloid::IO, we're actually making a
        # Celluloid::IO::TCPServer here
        @server = TCPServer.new(host, port)
      end

      def start
        async.run
      end
      
      def shutdown
        @server.close if @server
      end

      def run
        puts "RUNNING SERVER"
        loop { async.handle_connection @server.accept }
      end

      def handle_connection(socket)
        _, port, host = socket.peeraddr
        puts "*** Received connection from #{host}:#{port}"
        loop { socket.write socket.readpartial(4096) }
      rescue EOFError
        puts "*** #{host}:#{port} disconnected"
        socket.close
      end
    end
    
  class Server
    def start
      EventMachine.error_handler{ |e|
        begin
          Global.logger.error "Error raised during event loop: error=#{e} backtrace=#{e.backtrace[0,10]}"
        rescue
          puts "Error handling error: #{e}"
        end
      }

      
      EventMachine::run do
        host = "localhost"
        port = 4201 #Global.read_config("server", "port")
        EventMachine::add_periodic_timer(45) do
          AresMUSH.with_error_handling(nil, "Cron timer") do
           # Global.client_monitor.logged_in_clients.each { |c| c.ping }
          #  Cron.raise_event
          end
        end
                
        EventMachine::start_server(host, port, Connection) do |connection|
          AresMUSH.with_error_handling(nil, "Connection established") do
           # Global.client_monitor.connection_established(connection)
          end
        end

        web_port = 4202 #Global.read_config("server", "websocket_port")
        EventMachine::WebSocket.start(:host => host, :port => web_port) do |websocket|
          AresMUSH.with_error_handling(nil, "Web connection established") do
            WebConnection.new(websocket) do |connection|
              #Global.client_monitor.connection_established(connection)
            end
          end
        end
               
        #AresMUSH.with_error_handling(nil, "Web connection established") do
        #  dispatch = Rack::Builder.app do
        #    map '/' do
        #      AresWeb.run!
        #    end
        #  end

          # Start the web server. Note that you are free to run other tasks
          # within your EM instance.
        #  Rack::Server.start({
        #    app:    dispatch,
        #    server: 'thin',
        #    Host:   'localhost',
        #    Port:   '9292',
        #    signals: false,
        #  })
        #end
        
        Global.logger.info "Server started on #{host}:#{port}."
        #Global.dispatcher.queue_event GameStartedEvent.new
      end
    end
  end
end
