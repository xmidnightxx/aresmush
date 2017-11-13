module AresMUSH
  class Character
    attribute :role_admin_note
    
    def has_permission?(name)
      self.is_admin? || self.roles.any? { |r| r.has_permission?(name) }
    end
    
    def is_admin?
      self.has_any_role?("admin")
    end  

    def is_staff?
      self.has_any_role?("staff")
    end  

    def is_gm?
      self.has_any_role?("gm")
    end  

    def is_bld?
      self.has_any_role?("builder")
    end  

        
    def is_master_admin?
      self == Game.master.master_admin
    end
  end  
end