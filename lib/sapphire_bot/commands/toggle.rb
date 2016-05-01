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
          event.server.update_config(setting => { value: !event.server.config[setting][:value] })
          event << "#{event.server.config[setting][:description]} is now #{bool_to_words(event.server.config[setting][:value])}."
        else
          event << 'Unknown setting.'
        end
      end
    end
  end
end
