module SapphireBot
  module Commands
    module Leave
      extend Discordrb::Commands::CommandContainer
      command(:leave, required_permissions: [:manage_server],
                      description: 'Makes the bot leave this server.') do |event|
        event << 'See you. Meanwhile, take a look: <https://goo.gl/sSDDjp>'
        event.server.leave
      end
    end
  end
end
