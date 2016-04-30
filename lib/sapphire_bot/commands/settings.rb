module SapphireBot
  module Commands
    module Settings
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:settings, description: 'Displays current server settings.',
                         bucket: :default) do |event|
        event << "Automatic link shortening: #{bool_to_words(event.bot.server_config.shortening?(event.server.id))}."
      end
    end
  end
end
