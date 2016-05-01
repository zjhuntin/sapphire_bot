require 'terminal-table'

module Discordrb
  class Server
    attr_reader :config

    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |data, bot, exists = true|
      old_initialize.bind(self).call(data, bot, exists)
      @config = SapphireBot::ServerConfig.load_config(@id)
    end

    def update_config(attributes = {})
      @config.deep_merge!(attributes) if attributes.is_a?(Hash)
      SapphireBot::ServerConfig.update_servers(@config, @id)
    end

    def table
      Terminal::Table.new(headings: %w(Description Value Command)) do |t|
        @config.each do |_key, value|
          t.add_row([value[:description], value[:value], value[:command]])
        end
      end
    end

    def shortening?
      true if @config[:shortening][:value]
    end

    def preview?
      true if @config[:preview][:value]
    end
  end
end
