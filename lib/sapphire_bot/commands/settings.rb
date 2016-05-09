module SapphireBot
  module Commands
    module Settings
      extend Discordrb::Commands::CommandContainer
      command(:settings, description: 'Displays current server settings.',
                         bucket: :default) do |event|
        event << "\n`#{event.server.table}`"
      end
    end
  end
end
