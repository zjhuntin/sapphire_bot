module SapphireBot
  module Commands
    module Toggle
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:toggle, description: 'Allows you to toggle different bot settings server-wide.',
                       usage: 'toggle <settingname>',
                       required_permissions: [:manage_server],
                       bucket: :default, min_args: 1) do |event, setting|
        setting = setting.to_sym
        if event.server.config.keys.include?(setting.to_sym)
          event.server.update_config(setting => !event.server.config[setting])
          settings = SapphireBot::ServerConfig.settings
          event << "#{settings[setting][:description]} is now #{bool_to_words(event.server.config[setting])}."
        else
          event << 'Unknown setting.'
        end
      end
    end
  end
end
