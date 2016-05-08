module SapphireBot
  module Commands
    module Announce
      extend Discordrb::Commands::CommandContainer
      command(:announce, description: 'Announces your text server-wide.',
                         bucket: :default, min_args: 1,
                         required_permissions: [:manage_messages],
                         usage: 'announce <text>') do |event, *text|
        bot_profile = event.bot.profile.on(event.server)
        event.message.delete if bot_profile.permission?(:manage_messages, event.channel)
        text = GOOGLE.shorten_text(text.join(' '))
        event.server.text_channels.each do |channel|
          next unless bot_profile.permission?(:send_messages, channel)
          channel.send_message("**#{event.author.username}**: #{text}")
        end
        nil
      end
    end
  end
end
