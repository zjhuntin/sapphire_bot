module SapphireBot
  module ServerConfig
    extend StoreData

    @file = "#{Dir.pwd}/data/server_config.yml"
    @default_config = { shortening: false, preview: true }

    @servers = load_file(@file)

    def self.load_config(id)
      return @servers[id] if @servers.is_a?(Hash) && @servers.key?(id)
      LOGGER.info "created a new config entry for server #{id}."
      @servers[id] = @default_config.clone
    end

    def self.update_servers(config, id)
      @servers[id] = config
    end

    def self.save
      save_to_file(@file, @servers)
    end

    def self.settings
      {
        shortening: { description: 'Automatic link shortening', command: 'toggle shortening' },
        preview: { description: 'Preview for shorteneed links', command: 'toggle preview' }
      }
    end
  end
end
