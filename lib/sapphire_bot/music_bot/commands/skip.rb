module SapphireBot
  module MusicBot
    module Commands
      module Skip
        extend Discordrb::Commands::CommandContainer
        command(:skip, description: 'Skips current song.',
                       required_permissions: [:manage_server]) do |event|
          event.voice.stop_playing if event.voice
          nil
        end
      end
    end
  end
end
