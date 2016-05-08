module Discordrb
  class Server
    include SapphireBot::Helpers
    attr_reader :config

    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |data, bot, exists = true|
      old_initialize.bind(self).call(data, bot, exists)
      @config = SapphireBot::ServerConfig.load_config(@id)
    end

    def update_config(attributes = {})
      @config.merge!(attributes) if attributes.is_a?(Hash)
      SapphireBot::ServerConfig.update_servers(@config, @id)
    end

    def table
      settings_info = SapphireBot::ServerConfig.settings_info
      Terminal::Table.new(headings: %w(Description Value Command)) do |t|
        @config.each do |key, value|
          description = settings_info[key][:description]
          value = bool_to_words(value) if !!value == value
          command = "#{settings_info[key][:command]} #{settings_info[key][:setting]}"

          t.add_row([description, value, command])
        end
      end
    end

    def shortening?
      true if @config[:shortening]
    end

    def preview?
      true if @config[:preview]
    end

    def original?
      true if @config[:original]
    end

    def minlength
      @config[:minlength]
    end
  end
end
