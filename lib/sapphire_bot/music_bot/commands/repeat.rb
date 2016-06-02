module SapphireBot
  module MusicBot
    module Commands
      module Repeat
        extend Helpers
        extend Discordrb::Commands::CommandContainer
        command(:repeat, description: 'Toggles repeat.',
                         required_permissions: [:manage_server]) do |event|
          id = event.server.id
          if MusicBot.servers.key?(id)
            server = MusicBot.servers[id]
            server.repeat = !server.repeat
            event << "Repeat is now #{bool_to_words(server.repeat)}."
          end
          nil
        end
      end
    end
  end
end
