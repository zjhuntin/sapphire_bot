module SapphireBot
  module Commands
    # Prints server music queue.
    module Queue
      extend Discordrb::Commands::CommandContainer
      command(:queue, description: 'Displays current music queue.') do |event|
        if event.server.queue.empty?
          'Queue is empty, use `add` to add more songs.'
        else
          "`#{event.server.queue.table}`"
        end
      end
    end
  end
end
