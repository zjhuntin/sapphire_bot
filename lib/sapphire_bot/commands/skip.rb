module SapphireBot
  module Commands
    # Skips a song that's currently playing.
    module Skip
      extend Discordrb::Commands::CommandContainer
      command(:skip, description: 'Skips current song.',
                     required_permissions: [:manage_server]) do |event|
        break if event.server.music_player.queue.empty? || !event.server.music_player.playing?

        event.server.music_player.skip = true
        event.voice.stop_playing if event.voice
        nil
      end
    end
  end
end
