module SapphireBot
  module MusicBot
    module Commands
      module Queue
        extend Discordrb::Commands::CommandContainer
        command(:queue, description: 'Displays current queue.') do |event|
          id = event.server.id
          if MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            unless server.queue.empty?
              event << "`#{server.table}`"
              return
            end
          end
          'Queue is empty, use `add` to add more songs.'
        end
      end
    end
  end
end
