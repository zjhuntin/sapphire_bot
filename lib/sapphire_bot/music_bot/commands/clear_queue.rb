module SapphireBot
  module MusicBot
    module Commands
      module ClearQueue
        extend Discordrb::Commands::CommandContainer
        command(:clearqueue, description: 'Deletes songs from server queue.',
                             usage: 'clearqueue <index/all>',
                             required_permissions: [:manage_server],
                             min_args: 1) do |event, argument|
          id = event.server.id
          if MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            if argument.chomp == 'all'
              event.voice.stop_playing
              server.delete_dir
            elsif argument.to_i.between?(1, server.queue.length)
              index = argument.to_i - 1
              if index == 0
                event.voice.stop_playing
                server.queue.first.repeat = false
              else
                server.delete_song_at(index)
              end
            elsif !argument.to_i.between?(1, server.queue.length)
              event << "Can't find song with such index"
            else
              event << 'Unkonwn argument, use `all` or song index.'
            end
          end
          nil
        end
      end
    end
  end
end
