module SapphireBot
  class Stats
    attr_accessor   :servers_count, :users_count, :unique_users, :start_time,
                    :unique_users_count, :mentions, :start_time,
                    :urls_shortened, :messages_counter
    def initialize
      @file_path = "#{Dir.pwd}/data/stats"
      @urls_shortened = 0
      @messages_counter = 0
      @mentions = 0
      @unique_users = []
      @start_time = Time.now
      load
    end

    def update(bot)
      @servers_count = bot.servers.count
      @users_count = 0

      bot.servers.values.each do |server|
        server.members.each do |member|
          @users_count += 1
          @unique_users.push(member.id) unless @unique_users.include?(member.id)
        end
      end
      @unique_users_count = @unique_users.length
      save
    end

    def inspect
      LOGGER.info "servers: #{@servers_count} users: #{@users_count}"
    end

    private

    def load
      if File.exist?(@file_path)
        begin
          Marshal.load(File.binread(@file_path))
          LOGGER.info 'loaded stats from file'
        rescue => e
          LOGGER.log_exception e
        end
      else
        LOGGER.info 'no stats file'
      end
      @start_time = Time.now
    end

    def save
      File.open(@file_path, 'w') do |f|
        f.write(Marshal.dump(self))
      end
    rescue => e
      LOGGER.log_exception e
    end
  end
end
