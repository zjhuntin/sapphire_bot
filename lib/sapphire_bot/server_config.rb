module SapphireBot
  class ServerConfig
    include SapphireBot::StoreData
    def initialize
      @file = "#{Dir.pwd}/data/server_config.yml"
      @servers = load_file(@file)
      @servers = [] unless @servers
    end

    def find_server(id)
      @servers.find do |server|
        server[:id] == id
      end
    end

    def create(id)
      @servers.push(id: id, auto_shorten: false)
      save_to_file(@file, @servers)
      LOGGER.info "Created a new config entry for server #{id}."
    end

    def update(id, setting, value)
      find_server(id)[setting] = value
      save_to_file(@file, @servers)
    end

    def auto_shorten?(id)
      find_server(id)[:auto_shorten]
    end
  end
end
