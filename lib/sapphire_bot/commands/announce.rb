module SapphireBot
  module Commands
    # Announces a message server-wide.
    module Announce
      extend Discordrb::Commands::CommandContainer
      extend Helpers
      command(:announce, description: 'Announces your text server-wide.',
                         min_args: 1, required_permissions: [:manage_messages],
                         usage: 'announce <text>') do |event, *text|
        bot_profile = event.bot.profile.on(event.server)
        text = shorten_text(text.join(' '), preview: event.server.preview,
                                            original: event.server.original,
                                            minlength: event.server.minlength)

        event.server.text_channels.each do |channel|
          next unless bot_profile.permission?(:send_messages, channel)
          channel.send_message("**#{event.author.username}**: #{text}")
        end
        nil
      end
    end
  end
end
