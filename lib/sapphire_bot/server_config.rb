module SapphireBot
  module ServerConfig
    extend StoreData

    @file = "#{Dir.pwd}/data/server_config.yml"
    @default_config = { shortening: false }
    @servers = load_file(@file)

    def self.load_config(id)
      if @servers.key?(id)
        config = @servers[id]
      else
        LOGGER.info "created a new config entry for server #{id}."
        config = @default_config.clone
        @servers[id] = config
      end
    end

    def self.update_servers(config, id)
      @servers[id] = config
    end

    def self.save
      save_to_file(@file, @servers)
    end
  end
end
