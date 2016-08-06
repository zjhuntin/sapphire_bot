module SapphireBot
  module Commands
    # Adds a song to server queue and starts playing it.
    module Add
      extend Discordrb::Commands::CommandContainer
      command(:add, description: 'Adds a song to server queue and starts playing it.',
                    usage: 'add <query>', min_args: 1) do |event, *query|
        if !event.voice
          next 'First make me join your voice channel by using `join` command.'
        elsif event.server.queue.length >= MusicBot::MAX_SONGS_IN_QUEUE
          next 'Queue is too long.'
        end

        # Find the video and let user know if it does not exist.
        query = query.join(' ')
        video_id = GOOGLE.find_video(query)
        next 'Such video does not exist.' unless video_id

        # Download the song and add it to queue.
        # If this succeeds then start playing it unless music is already being played.
        if event.server.queue.add(video_id)
          event.server.queue.start_loop unless event.server.queue.playing?
        end
        nil
      end
    end
  end
end
