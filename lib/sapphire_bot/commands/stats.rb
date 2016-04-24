module SapphireBot
  module Commands
    module Stats
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:stats, bucket: :default,
                      description: 'Shows bot statistics') do |event|
        ping = ((Time.now - event.timestamp) * 1000).to_i
        event << ''
        event << "Servers: #{event.bot.stats.servers_count}."
        event << "Users: #{event.bot.stats.users_count}."
        event << "Unique users:  #{event.bot.stats.unique_users_count}."
        event << "Times mentioned: #{event.bot.stats.mentions}."
        event << "Uptime: #{time_in_words(Time.now - event.bot.stats.start_time)}."
        event << "Urls shortened: #{event.bot.stats.urls_shortened}."
        event << "Messages read: #{event.bot.stats.messages_counter}."
        event << "Ping: #{ping}ms."
      end
    end
  end
end
