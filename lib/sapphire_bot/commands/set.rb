module SapphireBot
  module Commands
    module Set
      extend Discordrb::Commands::CommandContainer
      command(:set, description: 'Allows you to set values of different bot settings server-wide.',
                    usage: 'set <setting> <value>',
                    required_permissions: [:manage_server],
                    bucket: :default, min_args: 2) do |event, setting, value|
        setting = setting.to_sym
        if event.server.config.keys.include?(setting.to_sym)
          setting_info = SapphireBot::ServerConfig.settings_info[setting]
          if setting_info[:command] == :set
            value = value.to_i
            if value.between?(setting_info[:min], setting_info[:max])
              event.server.update_config(setting => value)
              event << "#{setting_info[:description]} is now set to #{value}."
            else
              event << "The value must be between #{setting_info[:min]} and #{setting_info[:max]}."
            end
          else
            event << "Use `#{setting_info[:command]}` instead of `set` for this setting."
          end
        else
          event << 'Unknown setting.'
        end
      end
    end
  end
end
