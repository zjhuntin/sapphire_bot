module SapphireBot
  module ServerConfig
    extend StoreData

    @file = "#{Dir.pwd}/data/server_config.yml"
    @default_config = { shortening: { value: false, description: 'Automatic link shortening', command: 'toggle shortening' },
                        preview: { value: true, description: 'Preview for shorteneed links', command: 'toggle preview' } }
    @servers = load_file(@file)

    def self.load_config(id)
      return @servers[id] if @servers.key?(id)
      LOGGER.info "created a new config entry for server #{id}."
      @servers[id] = @default_config.clone
    end

    def self.update_servers(config, id)
      @servers[id] = config
    end

    def self.save
      save_to_file(@file, @servers)
    end
  end
end
