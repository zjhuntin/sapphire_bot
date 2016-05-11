module SapphireBot
  module Commands
    module Stats
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:stats, description: 'Shows bot statistics') do |event|
        ping = ((Time.now - event.timestamp) * 1000).to_i
        event << ''
        event << "Servers: #{STATS.servers}."
        event << "Users: #{STATS.users}."
        event << "Times mentioned: #{STATS.mentions}."
        event << "Uptime: #{time_in_words(STATS.uptime)}."
        event << "Urls shortened: #{STATS.urls_shortened}."
        event << "Youtube videos found: #{STATS.videos_found}"
        event << "Messages read: #{STATS.messages_read}."
        event << "Ping: #{ping}ms."
      end
    end
  end
end
