module SapphireBot
  module Commands
    module Default
      extend Discordrb::Commands::CommandContainer
      extend Helpers
      command(:default, description: 'Resets server setting (or all settings) to default',
                       usage: 'default <setting/all>',
                       required_permissions: [:manage_server],
                       bucket: :default, min_args: 1) do |event, setting|
        setting = setting.to_sym
        settings_info = SapphireBot::ServerConfig.settings_info
        setting_info = settings_info[setting] if settings_info.key?(setting)

        if setting == :all
          settings_info.each do |key, value|
            event.server.update_config(key => value[:default])
          end
          event << 'All settings set to default values.'
        elsif event.server.config.keys.include?(setting.to_sym)
          event.server.update_config(setting => setting_info[:default])
          default = if setting_info[:default].is_a?(TrueClass) ||
                       setting_info[:default].is_a?(FalseClass)
                      bool_to_words(setting_info[:default])
                    else
                      setting_info[:default]
                    end
          event << "#{setting_info[:description]} set to default, which is #{default}."
        else
          event << 'Unknown setting.'
        end
      end
    end
  end
end
