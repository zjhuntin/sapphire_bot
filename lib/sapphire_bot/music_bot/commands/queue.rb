module SapphireBot
  module MusicBot
    module Commands
      module Queue
        extend Discordrb::Commands::CommandContainer
        command(:queue, description: 'Displays current queue.') do |event|
          id = event.server.id
          if event.voice && MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            event << if !server.queue.empty?
                       "`#{server.table}`"
                     else
                       'Queue is empty, use `add` to add more songs.'
                     end
          end
        end
      end
    end
  end
end
