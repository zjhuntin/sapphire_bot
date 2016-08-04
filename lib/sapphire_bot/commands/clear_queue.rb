module SapphireBot
  module Commands
    # Removes a song from server queue or clears it completely.
    module ClearQueue
      extend Discordrb::Commands::CommandContainer
      command(:clearqueue, description: 'Deletes songs from server queue.',
                           usage: 'clearqueue <index/all>',
                           required_permissions: [:manage_server],
                           min_args: 1) do |event, argument|
        if argument.chomp == 'all'
          event.voice.stop_playing
          event.server.queue.delete_dir
        elsif argument.to_i.between?(1, event.server.queue.length)
          index = argument.to_i - 1
          if index.zero?
            event.voice.stop_playing
            event.server.queue.first.repeat = false
          else
            event.server.queue.delete_song_at(index)
          end
        elsif !argument.to_i.between?(1, event.server.queue.length)
          next "Can't find song with such index"
        else
          next 'Unkonwn argument, use `all` or song index.'
        end
        nil
      end
    end
  end
end
