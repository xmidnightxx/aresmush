module AresMUSH
  
  module Global
    def self.logger
      AresLogger.logger
    end
    
    def self.read_config(section, key = nil, subkey = nil)
      config_reader.get_config(section, key, subkey)
    end
    
    mattr_accessor :client_monitor, :plugin_manager, :dispatcher, :locale
  end
end