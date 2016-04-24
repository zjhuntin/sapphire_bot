module SapphireBot
  module Events
    module Pm
      module MassMessage
        extend ShortenText
        extend Discordrb::EventContainer
        pm(from: CONFIG[:owner_id]) do |event|
          text = shorten_text(event.message.content, event.bot)
          event.bot.servers.values.each do |server|
            profile = event.bot.profile.on(server)
            server.text_channels.each do |channel|
              next unless profile.permission?(:send_messages, channel)
              channel.send_message("**Mass message**: #{text}")
            end
          end
        end
      end
    end
  end
end
