module SapphireBot
  module Events
    module Message
      module MessagesCounter
        extend Discordrb::EventContainer
        message(starting_with: not!(PREFIX),
                private: false) do |event|
          STATS.messages_counter += 1 unless event.author.current_bot?
        end
      end
      module AutoShorten
        extend ShortenText
        extend Discordrb::EventContainer
        message(starting_with: not!(PREFIX),
                private: false) do |event|
          unless event.from_bot?
            if event.bot.profile.on(event.server).permission?(:manage_messages,
                                                              event.channel)
              text = shorten_text(event.message.content)
              if event.message.content != text
                event.send_message("**#{event.author.username}**: #{text}")
                event.message.delete
              end
            end
          end
        end
      end
    end
  end
end
