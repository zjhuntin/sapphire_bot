module SapphireBot
  class ServerConfig
    include StoreData
    def initialize
      @file = "#{Dir.pwd}/data/server_config.yml"
      @servers = load_file(@file)
      @servers = {} unless @servers
    end

    def create(id)
      @servers[id] = { shortening: false }
      save_to_file(@file, @servers)
      LOGGER.info "created a new config entry for server #{id}."
    end

    def update(id, setting, value)
      @servers[id][setting] = value
      save_to_file(@file, @servers)
    end

    def shortening?(id)
      @servers[id][:shortening]
    end

    def server_exists?(id)
      true if @servers[id]
    end
  end
end
