module SapphireBot
  class Bot < Discordrb::Commands::CommandBot
    attr_accessor :stats, :server_config, :shortener
    def initialize(attributes = {})
      super(attributes)
      @stats = Stats.new
      @shortener = Shortener.new
    end
  end
end
