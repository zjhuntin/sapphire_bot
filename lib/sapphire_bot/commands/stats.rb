module SapphireBot
  module Commands
    module Stats
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:stats, bucket: :default,
                      description: 'Shows bot statistics') do |event|
        ping = ((Time.now - event.timestamp) * 1000).to_i
        event << ''
        event << "Servers: #{STATS.servers_count}."
        event << "Users: #{STATS.users_count}."
        event << "Unique users:  #{STATS.unique_users_count}."
        event << "Times mentioned: #{STATS.mentions}."
        event << "Uptime: #{time_in_words(Time.now - STATS.start_time)}."
        event << "Urls shortened: #{STATS.urls_shortened}."
        event << "Messages read: #{STATS.messages_counter}."
        event << "Ping: #{ping}ms."
      end
    end
  end
end
