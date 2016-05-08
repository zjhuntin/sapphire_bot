module SapphireBot
  module ServerConfig
    extend StoreData

    @file = "#{Dir.pwd}/data/server_config.yml"
    @default_config = { shortening: false, preview: true, original: true, minlength: 21}

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

    def self.settings_info
      {
        shortening: {
          description: 'Automatic link shortening',
          command: :toggle,
          setting: 'shortening'
        },
        preview: {
          description: 'Preview for shorteneed links',
          command: :toggle,
          setting: 'preview'
        },
        original: {
          description: 'Original host before shortened links',
          command: :toggle,
          setting: 'original'
        },
        minlength: {
          description: 'Minimum link length to shorten',
          command: :set,
          setting: 'minlength',
          min: 21,
          max: 2083
        }
      }
    end
  end
end
