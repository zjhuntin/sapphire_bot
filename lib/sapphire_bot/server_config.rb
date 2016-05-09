module SapphireBot
  module ServerConfig
    extend StoreData

    @default_settings = load_file("#{Dir.pwd}/data/default_settings.yml")
    @servers = load_file("#{Dir.pwd}/data/server_config.yml")

    def self.load_config(id)
      return @servers[id] if @servers.key?(id)

      @servers[id] = {}
      @default_settings.each do |key, value|
        @servers[id][key] = value[:default]
      end
      LOGGER.info "created a new config entry for server #{id}."

      @servers[id]
    end

    def self.update_servers(config, id)
      @servers[id] = config
    end

    def self.save
      save_to_file("#{Dir.pwd}/data/server_config.yml", @servers)
    end

    def self.settings_info
      @default_settings
    end
  end
end
