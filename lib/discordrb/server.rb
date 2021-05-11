module Discordrb
  # Add functionality needed for sapphire to Discordrb::Server.
  class Server
    # Server music player for this server.
    attr_reader :music_player

    attr_reader :config

    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |data, bot, exists = true|
      old_initialize.bind(self).call(data, bot, exists)
      @config = SapphireBot::ServerConfig.load_config(@id)
      @music_player = SapphireBot::MusicBot::MusicPlayer.new(@id)
      create_methods
    end

    def update_config(attributes = {})
      @config.merge!(attributes) if attributes.is_a?(Hash)
      SapphireBot::ServerConfig.update_servers(@config, @id)
    end

    def table
      Terminal::Table.new(headings: %w(Description Value Command)) do |t|
        @config.each do |key, value|
          setting_info = SapphireBot::ServerConfig.settings_info[key]
          description = setting_info[:description]
          value = bool_to_words(value) if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          command = "#{setting_info[:command]} #{setting_info[:setting]}"

          t.add_row([description, value, command])
        end
      end
    end

    private

    def create_methods
      @config.keys.each do |key|
        self.class.send(:define_method, key) do
          @config[key]
        end
      end
    end
  end
end
