require 'ansi'

module AresMUSH
  
  class SystemNotFoundException < Exception
  end
  
  class AddonManager
    def initialize(game_dir)
      @addons_path = File.join(game_dir, "addons")
      @addons = []
    end
    
    attr_reader :addons
    attr_accessor :container

    def register_addon(sym)
      addon = sym.new(@container)
      logger.debug "Registering #{addon}. commands: #{addon.commands}."
      addon.on_registered
      @addons << addon
      @addons.each { |a| puts "#{a} #{a.respond_to?(:on_player_command)}"}
    end
    
    def load_all
      addon_files = Dir[File.join(@addons_path, "**", "*.rb")]
      @addons = []
      load_addon_code(addon_files)
    end
    
    def load_addon(name)
      puts addons
      addon_files = Dir[File.join(@addons_path, name, "**", "*.rb")]
      raise SystemNotFoundException if addon_files.empty?
      load_addon_code(addon_files)      
    end
      
    private    
    def load_addon_code(files)
      files.each do |f| 
        logger.info "Loading #{f}."
        load f
      end
    end 
  end
end