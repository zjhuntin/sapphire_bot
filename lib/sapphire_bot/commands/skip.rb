module SapphireBot
  module Commands
    # Skips a song that's currently playing.
    module Skip
      extend Discordrb::Commands::CommandContainer
      command(:skip, description: 'Skips current song.',
                     required_permissions: [:manage_server]) do |event|
        break if event.server.queue.empty? || !event.server.queue.playing?

        event.server.queue.skip = true
        event.voice.stop_playing if event.voice
        nil
      end
    end
  end
end
