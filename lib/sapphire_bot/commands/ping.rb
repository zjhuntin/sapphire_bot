module SapphireBot
  module Commands
    module Ping
      extend Discordrb::Commands::CommandContainer
      command(:ping, description: 'Responds with respond time') do |event|
        event << "#{((Time.now - event.timestamp) * 1000).to_i}ms."
      end
    end
  end
end
