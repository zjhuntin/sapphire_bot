module SapphireBot
  module Events
    # Adds one to messages read stat every time a new message is received.
    module MessagesReadStat
      extend Discordrb::EventContainer
      message(starting_with: not!(CONFIG.prefix),
              private: false) do |event|
        STATS.messages_read += 1 unless event.author.current_bot?
      end
    end

    # Automatically shortens urls.
    module AutoShorten
      extend Discordrb::EventContainer
      message(starting_with: not!(CONFIG.prefix),
              private: false) do |event|
        unless event.from_bot?
          bot_profile = event.bot.profile.on(event.server)
          if bot_profile.permission?(:manage_messages, event.channel) &&
             event.server.shortening
            text = GOOGLE.shorten_text(event)
            unless event.message.content == text
              event.send_message("**#{event.author.username}**: #{text}")
              event.message.delete
            end
          end
        end
      end
    end
  end
end
