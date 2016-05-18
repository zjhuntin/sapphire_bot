module SapphireBot
  module MusicBot
    module Commands
      module Leave
        extend Discordrb::Commands::CommandContainer
        command(:leave, description: 'Makes the bot leave your voice channel.',
                        required_permissions: [:manage_server]) do |event|
          if event.voice
            event.voice.destroy
            MusicBot.delete_server(event.server.id)
          end
          nil
        end
      end
    end
  end
end
