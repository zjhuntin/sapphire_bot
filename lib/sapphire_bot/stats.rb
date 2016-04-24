module SapphireBot
  class Stats
    include StoreData
    attr_accessor :stats_hash
    def initialize
      @file = "#{Dir.pwd}/data/stats.yml"
      @stats_hash = {}
      @stats_hash[:urls_shortened] = 0
      @stats_hash[:messages_read] = 0
      @stats_hash[:urls_shortened] = 0
      @stats_hash[:mentions] = 0
      temp = load_file(@file)
      @stats_hash = temp if temp
      @start_time = Time.now.to_i
    end

    def update(bot)
      @stats_hash[:servers] = bot.servers.size
      @stats_hash[:users] = 0

      bot.servers.values.each do |server|
        @stats_hash[:users] += server.members.size
      end
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

    def servers
      @stats_hash[:servers]
    end

    def users
      @stats_hash[:users]
    end

    def uptime
      @stats_hash[:uptime] = (Time.now - @start_time).to_i
    end

    def inspect
      puts ''
      @stats_hash.each { |key, value| LOGGER.info "#{key}: #{value} " unless key == :start_time }
    end
  end
end
