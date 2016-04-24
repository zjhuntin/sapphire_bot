module SapphireBot
  module Commands
    module Announce
      extend ShortenText
      extend Discordrb::Commands::CommandContainer
      command(:announce, description: 'Announces your text server-wide.',
                         bucket: :default, min_args: 1,
                         usage: 'announce <text>') do |event, *text|
        if event.author.permission?(:manage_messages, event.channel)
          event.message.delete if event.bot.profile.on(event.server)
                                       .permission?(:manage_messages,
                                                    event.channel)
          text = shorten_text(text.join(' '), event.bot)
          event.server.text_channels.each do |channel|
            profile = event.bot.profile.on(event.server)
            next unless profile.permission?(:send_messages, channel)
            channel.send_message("**#{event.author.username}**: #{text}")
          end
          nil
        else
          event << 'You need `manage messages` permission to use this.'
        end
      end
    end
  end
end
