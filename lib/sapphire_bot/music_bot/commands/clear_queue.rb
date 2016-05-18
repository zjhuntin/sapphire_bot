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
          if event.voice && MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            if argument.chomp.casecmp('all').zero?
              event.voice.stop_playing
              server.delete_dir
            elsif server.queue.length >= argument.to_i - 1 && argument.to_i >= 1
              index = argument.to_i - 1
              event.voice.stop_playing if index == 0
              server.delete_song_at(index)
            elsif server.queue.length < argument.to_i - 1 || argument.to_i < 1
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
