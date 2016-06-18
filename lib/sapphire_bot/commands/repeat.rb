module SapphireBot
  module Commands
    # Toggles server queue repeat state.
    module Repeat
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:repeat, description: 'Toggles repeat.',
                       required_permissions: [:manage_server]) do |event|
        event.server.queue.repeat = !event.server.queue.repeat
        "Repeat is now #{bool_to_words(event.server.queue.repeat)}."
      end
    end
  end
end
