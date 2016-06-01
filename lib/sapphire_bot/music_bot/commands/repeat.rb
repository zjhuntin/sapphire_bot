module SapphireBot
  module MusicBot
    module Commands
      module Skip
        extend Discordrb::Commands::CommandContainer
        command(:repeat, description: 'Repeats the current song.',
                         required_permissions: [:manage_server]) do |event|
          id = event.server.id
          if MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            server.queue.first.repeat = !server.queue.first.repeat
          end
          nil
        end
      end
    end
  end
end
