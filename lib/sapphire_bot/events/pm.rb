module SapphireBot
  module Events
    # Sends messages to every channel bot is connected to, when receives a message from owner.
    module MassMessage
      extend Discordrb::EventContainer
      extend Helpers
      pm(from: CONFIG.owner_id) do |event|
        text = shorten_text(event)
        event.bot.servers.values.each do |server|
          bot_profile = event.bot.profile.on(server)
          server.text_channels.each do |channel|
            next unless bot_profile.permission?(:send_messages, channel)
            channel.send_message("**Mass message**: #{text}")
          end
        end
      end
    end
  end
end
