module SapphireBot
  module Commands
    module KickAll
      extend Discordrb::Commands::CommandContainer
      command(:kickall,
              description: 'Kicks all the members from the server, except you.',
              bucket: :default) do |event|
        if event.author.permission?(:kick_members, event.server)
          event.server.members.each do |member|
            event.server.kick(member.id) unless member.id == event.author.id ||
                                                member.current_bot? ||
                                                member.owner?
          end
          nil
        else
          event << 'You need `kick members` permission to use this.'
        end
      end
    end
  end
end
