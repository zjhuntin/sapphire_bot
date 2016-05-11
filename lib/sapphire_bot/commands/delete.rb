module SapphireBot
  module Commands
    module Delete
      extend Discordrb::Commands::CommandContainer
      command(:delete, description: 'Deletes messages in this channel.',
                       min_args: 1, required_permissions: [:manage_messages],
                       usage: 'delete <ammount>') do |event, ammount|
        if event.bot.profile.on(event.server).permission?(:manage_messages,
                                                          event.channel)
          ammount = ammount.to_i + 1
          while ammount > 100
            event.channel.prune(100)
            ammount -= 100
          end
          event.channel.prune(ammount)
          nil
        end
      end
    end
  end
end
