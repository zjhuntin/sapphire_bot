module SapphireBot
  module Commands
    # Displays server settings table.
    module Settings
      extend Discordrb::Commands::CommandContainer
      command(:settings, description: 'Displays server settings.') do |event|
        "\n`#{event.server.table}`"
      end
    end
  end
end
