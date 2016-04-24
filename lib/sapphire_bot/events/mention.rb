module SapphireBot
  module Events
    module Mention
      extend Discordrb::EventContainer
      mention do |event|
        string = if event.bot.server_config.auto_shorten?(event.server.id)
                   'enabled'
                 else
                   'disabled'
                 end
        event.respond("Sapphire v#{VERSION} live and ready! Automatic link shortening is #{string}.")
        event.bot.stats.stats_hash[:mentions] += 1
      end
    end
  end
end
