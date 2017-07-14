module AresMUSH
  module FS3Combat
    class ReloadAction < CombatAction
      
      def prepare
        return t('fs3combat.cant_reload') if !self.combatant.max_ammo
        return nil
      end

      def print_action
        msg = t('fs3combat.reload_action_msg_long', :name => self.name)
      end
      
      def print_action_short
        t('fs3combat.reload_action_msg_short')
      end
            
      def resolve
        # New code added here to handle multi-round reloads. 
        messages = []

        r = self.combatant.reload_counter + 1
        t = FS3Combat.weapon_stat(self.combatant.weapon, "reload_turns")
        if (r == t)
           messages << t('fs3combat.reload_action_complete', :name => self.name, :round => r, :max_round => t)
           self.combatant.update(ammo: self.combatant.max_ammo)
           self.combatant.update(reload_counter: 0)
           self.combatant.update(action_klass: nil)
           self.combatant.update(action_args: nil)
           messages << t('fs3combat.resetting_action_reload', :name => self.name)
        else
           self.combatant.update(reload_counter: r)
           messages << t('fs3combat.reload_action_inprog', :name => self.name, :round => r, :max_round => t)
        end

        messages
      end
    end
  end
end