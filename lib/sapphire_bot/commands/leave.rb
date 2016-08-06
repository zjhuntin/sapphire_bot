module SapphireBot
  module Commands
    # Makes the bot disconnect from current voice channel.
    module Leave
      extend Discordrb::Commands::CommandContainer
      command(:leave, description: 'Makes the bot leave your voice channel.',
                      required_permissions: [:manage_server]) do |event|
        event.server.music_player.disconnect
        nil
      end
    end
  end
end
