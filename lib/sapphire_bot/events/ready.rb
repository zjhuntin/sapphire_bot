module SapphireBot
  module Events
    # Notifies user that bot is ready to use.
    module ReadyMessage
      extend Discordrb::EventContainer
      ready do
        LOGGER.info 'Bot is ready'
      end
    end
  end
end
