module SapphireBot
  module Commands
    module Announce
      extend Discordrb::Commands::CommandContainer
      command(:announce, description: 'Announces your text server-wide.',
                         bucket: :default, min_args: 1,
                         required_permissions: [:manage_messages],
                         usage: 'announce <text>') do |event, *text|
        event.message.delete if event.bot.profile.on(event.server).permission?(:manage_messages,
                                                                               event.channel)
        text = event.bot.shortener.shorten_text(event, text.join(' '))
        event.server.text_channels.each do |channel|
          profile = event.bot.profile.on(event.server)
          next unless profile.permission?(:send_messages, channel)
          channel.send_message("**#{event.author.username}**: #{text}")
        end
        nil
      end
    end
  end
end
