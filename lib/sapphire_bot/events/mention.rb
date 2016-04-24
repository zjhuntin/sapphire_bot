module SapphireBot
  module Events
    module Mention
      extend Discordrb::EventContainer
      mention do |event|
        event.respond("Sapphire v#{VERSION} live and ready!")
        event.bot.stats.stats_hash[:mentions] += 1
      end
    end
  end
end
