module SapphireBot
  module Commands
    module KickAll
      extend Discordrb::Commands::CommandContainer
      command(:kickall,
              description: 'Kicks all the members from the server, except you.',
              required_permissions: [:kick_members],
              bucket: :default) do |event|
        event.server.members.each do |member|
          event.server.kick(member.id) unless member.id == event.author.id ||
                                              member.current_bot? ||
                                              member.owner?
        end
        nil
      end
    end
  end
end
