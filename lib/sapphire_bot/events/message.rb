module SapphireBot
  module Events
    module MessagesReadStat
      extend Discordrb::EventContainer
      extend Helpers
      message(starting_with: not!(CONFIG.prefix),
              private: false) do |event|
        STATS.messages_read += 1 unless event.author.current_bot?
      end
    end
    module AutoShorten
      extend Discordrb::EventContainer
      extend Helpers
      message(starting_with: not!(CONFIG.prefix),
              private: false) do |event|
        unless event.from_bot?
          bot_profile = event.bot.profile.on(event.server)
          if bot_profile.permission?(:manage_messages, event.channel) &&
             event.server.shortening
            text = shorten_text(event)
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
