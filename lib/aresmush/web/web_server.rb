require 'angelo'
require 'celluloid'

module AresMUSH  

  class Ares
    include Celluloid::IO

    def initialize
      puts "Ares Init"
      #Celluloid.every 5 do
      #  ping
      #end
      bootstrapper = AresMUSH::Bootstrapper.new      
    end
  
    def foo
      puts "foo"
      "foo"
    end
  
    def ping
      puts "Pinged"
    end
  
  end

  
  class AresWeb < Angelo::Base

    HEART = '<3'
    CORS = { 'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Methods' => 'GET, POST',
      'Access-Control-Allow-Headers' => 'Accept, Authorization, Content-Type, Origin' }

      # a flag to know if the :heart task is running
      #
      @@game = Ares.new
      @@hearting = false
    
      before '/api/*' do
        headers CORS
        if request.path == "/api/tokenauth" 
          puts "Token auth"      
        elsif request.headers['Authorization'] == "Bearer 123"      
          puts "Auth OK"
        elsif request.method == "OPTIONS"
          puts "Options OK"
        else
          puts "Failed authentication"
          raise RequestError.new 'not authorized', 401
        end
      end

      options '*' do
        headers CORS
        nil
      end
  
      post '/api/load/:plugin' do
        headers CORS
        content_type :json
        puts "Got post #{params[:plugin]}"
        begin
        
          load File.join(AresMUSH.game_path, "web", "#{params[:plugin]}.rb")
        rescue Exception => e
          puts "Die #{e}"
        end
      
        data = { token: 123 }
        data.to_json
      
      end
    
      get '/foo' do
        @@game.foo
      end
    
      get '/ping' do
        pong
      end
  
      post '/api/tokenauth' do
        headers CORS
        content_type :json

        data = { token: 123 }
        data.to_json
      end
  
  
      # emit the TEST JSON value on all :emit_test websockets
      # return the params posted as JSON
      #
      post '/emit' do
        websockets[:emit_test].each {|ws| ws.write TEST}
        params.to_json
      end

      # handle websocket requests at '/ws'
      # stash them in the :emit_test context
      # write 6 messages to the websocket whenever a message is received
      #
      websocket '/ws' do |ws|
        websockets[:emit_test] << ws
        ws.on_message do |msg|
          5.times { ws.write TEST }
          ws.write foo.to_json
        end
      end

      # emit the TEST JSON value on all :other websockets
      #
      post '/other' do
        websockets[:other].each {|ws| ws.write TEST}
        ''
      end

      # stash '/other/ws' connected websockets in the :other context
      #
      websocket '/other/ws' do |ws|
        websockets[:other] << ws
      end

      websocket '/hearts' do |ws|

        # this is a call to Base#async, actually calling
        # the reactor to start the task
        #
        async :hearts unless @@hearting

        websockets[:hearts] << ws
      end

      # this is a call to Base.task, defining the task
      # to perform on the reactor
      #
      task :hearts do
        @@hearting = true
        every(10){ websockets[:hearts].each {|ws| ws.write HEART } }
      end
    
      post '/in/:sec/sec/:msg' do

        # this is a call to Base#future, telling the reactor
        # do this thing and we'll want the value eventually
        #
        f = future :in_sec, params[:sec], params[:msg]
        f.value
      end

      # define a task on the reactor that sleeps for the given number of
      # seconds and returns the given message
      #
      task :in_sec do |sec, msg|
        sleep sec.to_i
        msg
      end
    end
  end