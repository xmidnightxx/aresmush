module AresMUSH
  module Addon
    def initialize(container)
      @container = container
    end
    
    attr_reader :container
    
    def crack_command(client, cmd)
    end

    # Override this with any custom initialization
    def on_registered
    end
    
    # Override this with an array of commands you handle
    # Example:
    #   [ "who", "where" ]
    #   nil -- You don't handle commands
    #   [] -- You want to see ALL commands (perhaps for channels)
    def commands
      nil
    end

    # Override this with a regex that parses out your command args into
    # the Match Data
    # Example:
    #   "create (?<name>\\S+) (?<password>\\S+)"
    def command_args
    end
    
    
    def self.included(receiver)
      Bootstrapper::addon_manager.register_addon(receiver)
    end
    
  end
end