module SapphireBot
  module MusicBot
    MAX_SONG_LENGTH = 600

    MAX_SONGS_IN_QUEUE = 15

    @servers = {}

    def self.servers
      @servers
    end

    def self.add_server(id)
      @servers[id] = ServerQueue.new(id)
    end

    def self.delete_server(id)
      @servers[id].delete_dir
      @servers.delete(id)
    end

    def self.delete_files
      @servers.each do |_key, value|
        value.delete_dir
      end
    end
  end
end
