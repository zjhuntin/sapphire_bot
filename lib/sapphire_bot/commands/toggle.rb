module SapphireBot
  module Commands
    # Toggles bot settings server-wide.
    module Toggle
      extend Discordrb::Commands::CommandContainer
      command(:toggle, description: 'Allows you to toggle different bot settings server-wide.',
                       usage: 'toggle <setting>',
                       required_permissions: [:manage_server],
                       min_args: 1) do |event, setting|
        setting = setting.to_sym
        if event.server.config.keys.include?(setting.to_sym)
          setting_info = SapphireBot::ServerConfig.settings_info[setting]
          if setting_info[:command] == :toggle
            event.server.update_config(setting => !event.server.config[setting])
            "#{setting_info[:description]} is now #{bool_to_words(event.server.config[setting], :enabled)}."
          else
            "Use `#{setting_info[:command]}` instead of `toggle` for this setting."
          end
        else
          'Unknown setting.'
        end
      end
    end
  end
end
