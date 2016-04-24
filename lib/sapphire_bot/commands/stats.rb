module SapphireBot
  module Commands
    module Stats
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:stats, bucket: :default,
                      description: 'Shows bot statistics') do |event|
        ping = ((Time.now - event.timestamp) * 1000).to_i
        event << ''
        event << "Servers: #{event.bot.stats.servers}."
        event << "Users: #{event.bot.stats.users}."
        event << "Times mentioned: #{event.bot.stats.mentions}."
        event << "Uptime: #{time_in_words(event.bot.stats.uptime)}."
        event << "Urls shortened: #{event.bot.stats.urls_shortened}."
        event << "Messages read: #{event.bot.stats.messages_read}."
        event << "Ping: #{ping}ms."
      end
    end
  end
end
