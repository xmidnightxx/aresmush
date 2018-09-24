module AresMUSH
  module Page
    def self.add_to_monitor(char, monitor_name, message)
      monitor = char.page_monitor
      
      if (!monitor[monitor_name])
        monitor[monitor_name] = []
      end
      
      if (monitor[monitor_name].count > 30)
        monitor[monitor_name].shift
      end
      monitor[monitor_name] << "#{Time.now} #{message}"
      char.update(page_monitor: monitor)
    end
    
    def self.add_to_history(sender, char, recipients, message)
      return if !char.page_history_enabled?

      everyone = [ sender ].concat(recipients)
      history_name = everyone.select { |r| r != char }.map { |r| r.name }.sort.join(", ")
      history = char.page_history
      history_entry = {
          date: Time.now,
          message: message
        }
        
      if (!history[history_name])
        history[history_name] = [ history_entry ]
      else
        history[history_name] << history_entry
      end

      char.update(page_history: history)
    end
    
    def self.page_recipient(sender, other_client, other_char, recipients, message)
      if (other_char.page_do_not_disturb)
        client.emit_ooc t('page.recipient_do_not_disturb', :name => other_char.name)
      else          
        recipient_names = recipients.map { |r| r.name }.join(",")

        other_client.emit t('page.to_recipient', 
        :autospace => other_char.page_autospace, 
        :color => other_char.page_color, 
        :recipients => recipient_names, 
        :message => message)
        Page.send_afk_message(other_client, other_char)
        
        Page.add_to_history(sender, other_char, recipients, message)
      end
      
      
      if (other_char.is_monitoring?(sender))
        Page.add_to_monitor(other_char, sender.name, message)
      end
      
      if (sender.is_monitoring?(other_char))
        Page.add_to_monitor(sender, other_char.name, message)
      end
    end
          
    def self.send_afk_message(other_client, other_char)
      if (other_char.is_afk)
        afk_message = ""
        if (other_char.afk_display)
          afk_message = "(#{other_char.afk_display})"
        end
        afk_message = t('page.recipient_is_afk', :name => other_char.name, :message => afk_message)
        client.emit_ooc afk_message
        other_client.emit_ooc afk_message
      elsif (Status.is_idle?(other_client))
        time = TimeFormatter.format(other_client.idle_secs)
        afk_message = t('page.recipient_is_idle', :name => other_char.name, :time => time)
        client.emit_ooc afk_message
        other_client.emit_ooc afk_message
      end
    end
    
  end
end