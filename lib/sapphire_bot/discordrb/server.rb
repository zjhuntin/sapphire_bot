module Discordrb
  class Server
    attr_reader :config

    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |data, bot, exists = true|
      old_initialize.bind(self).call(data, bot, exists)
      @config = SapphireBot::ServerConfig.load_config(@id)
    end

    def update_config(attributes = {})
      @config.merge!(attributes) if attributes.is_a? Hash
      SapphireBot::ServerConfig.update_servers(@config, @id)
    end

    def shortening?
      true if @config[:shortening]
    end
  end
end
