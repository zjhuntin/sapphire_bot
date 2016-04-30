module SapphireBot
  module ServerConfig
    extend StoreData

    @file = "#{Dir.pwd}/data/server_config.yml"
    @default_config = { shortening: false }
    @servers = {}

    def self.load_config(id)
      config = load_file(@file)
      unless config
        config = @default_config.clone
        LOGGER.info "created a new config entry for server #{id}."
      end
      @servers[id] = config
      config
    end

    def self.update_servers(config, id)
      @servers[id] = config
    end

    def self.save
      save_to_file(@file, @servers)
    end
  end
end
