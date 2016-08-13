require 'yaml'

module AresMUSH  
  class Database

    def load_config
      db_config = YAML.load_file File.join(AresMUSH.game_path, 'config', 'database.yml')
      default_client_config = db_config['database']['production']['clients']['default']
      host = default_client_config['hosts']
      db_name = default_client_config['database']
      Global.logger.info("Database config: #{host} #{db_name}")
      
      begin
        Mongoid.load_configuration(db_config['database']['production'])
        
        Mongoid.logger.level = Logger::WARN
        Mongo::Logger.logger.level = Logger::WARN            
            
      rescue Exception => e
        Global.logger.fatal("Error loading database config.  Please check your dabase configuration and installation requirements: #{e}.")      
        raise e
      end      
    end       
  end
end