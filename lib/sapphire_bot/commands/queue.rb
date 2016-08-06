module SapphireBot
  module Commands
    # Prints server's music queue.
    module Queue
      extend Discordrb::Commands::CommandContainer
      command(:queue, description: 'Displays current music queue.') do |event|
        if event.server.music_player.queue.empty?
          'Queue is empty, use `add` to add more songs.'
        else
          "`#{event.server.music_player.table}`"
        end
      end
    end
  end
end
