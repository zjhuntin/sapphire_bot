module SapphireBot
  module Commands
    module Settings
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:settings, description: 'Displays current server settings.',
                         bucket: :default) do |event, option|
      event << "Automatic link shortening: #{bool_to_words(event.bot.server_config.auto_shorten?(event.server.id))}."
      end
    end
  end
end
