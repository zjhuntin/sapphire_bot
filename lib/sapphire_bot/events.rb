module SapphireBot
  # Module for sapphire events.
  module Events
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| require file }

    @events = [
      Mention,
      MessagesReadStat,
      AutoShorten,
      MassMessage,
      ReadyMessage
    ]

    def self.include!
      @events.each do |event|
        SapphireBot::BOT.include!(event)
      end
    end
  end
end
