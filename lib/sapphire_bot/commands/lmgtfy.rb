module SapphireBot
  module Commands
    module Lmgtfy
      extend Discordrb::Commands::CommandContainer
      extend Helpers
      command(:lmgtfy, bucket: :default, min_args: 1,
                       description: 'Generates Let Me Goole That For You link.',
                       usage: 'lmgtfy <text>') do |event, *text|
        bot_profile = event.bot.profile.on(event.server)
        event.message.delete if bot_profile.permission?(:manage_messages, event.channel)
        shorten_text("http://lmgtfy.com/?q=#{text.join('+')}",
                                            preview: event.server.preview?,
                                            original: event.server.original?,
                                            minlength: event.server.minlength)
      end
    end
  end
end
