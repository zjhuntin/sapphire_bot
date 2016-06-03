module SapphireBot
  module MusicBot
    module Commands
      module Add
        extend Discordrb::Commands::CommandContainer
        command(:add, description: 'Adds a song to server queue and starts playing it.',
                      usage: 'add <query>', min_args: 1) do |event, *query|
          if event.voice
            query = query.join(' ')

            video_id = GOOGLE.find_video(query)
            unless video_id
              event << 'Such video does not exist.'
              return
            end

            id = event.server.id
            MusicBot.add_server(id) unless MusicBot.servers.key?(id)
            server = MusicBot.servers[id]

            if server.queue.length >= MAX_SONGS_IN_QUEUE
              event << 'Queue is too long.'
              return
            end

            if server.add_to_queue(video_id, event)
              server.start_loop(event) unless server.playing
            end
            nil
          else
            'First make me join your voice channel by using `join` command.'
          end
        end
      end
    end
  end
end
