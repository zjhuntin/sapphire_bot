module SapphireBot
  module Events
    module ReadyMessage
      extend Discordrb::EventContainer
      ready do
        LOGGER.info 'Bot is ready'
      end
    end
  end
end
