module SapphireBot
  class Stats
    include StoreData

    attr_accessor :stats_hash

    attr_reader :servers, :users

    def initialize
      @file = "#{Dir.pwd}/data/stats.yml"

      temp = load_file(@file)
      if temp.is_a?(Hash) && !temp.empty?
        @stats_hash = temp
      else
        @stats_hash = {}
        @stats_hash[:urls_shortened] = 0
        @stats_hash[:messages_read] = 0
        @stats_hash[:urls_shortened] = 0
        @stats_hash[:videos_found] = 0
        @stats_hash[:mentions] = 0
      end

      @start_time = Time.now.to_i
    end

    def update(bot)
      @servers = bot.servers.size
      @users = bot.users.size
    end

    def save
      save_to_file(@file, @stats_hash)
    end

    def urls_shortened
      @stats_hash[:urls_shortened]
    end

    def messages_read
      @stats_hash[:messages_read]
    end

    def mentions
      @stats_hash[:mentions]
    end

    def videos_found
      @stats_hash[:videos_found]
    end

    def uptime
      (Time.now - @start_time).to_i
    end

    def inspect
      LOGGER.info "users: #{@users}"
      LOGGER.info "servers: #{@servers}"
      LOGGER.info "uptime: #{uptime}"
      @stats_hash.each { |key, value| LOGGER.info "#{key.to_s.gsub('_', ' ')}: #{value} " }
    end
  end
end
