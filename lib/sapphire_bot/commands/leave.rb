module SapphireBot
  module Commands
    module Leave
      extend Discordrb::Commands::CommandContainer
      command(:leave, bucket: :default,
                      description: 'Makes the bot leave this server.') do |event|
        if event.author.owner? ||
           event.author.permission?(:kick_members, event.server)
          event event << 'See you. Meanwhile, take a look: <https://goo.gl/sSDDjp>'
          event.server.leave
        else
          event << `You need kick members permission to use this.`
        end
      end
    end
  end
end
