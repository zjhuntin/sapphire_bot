module SapphireBot
  class Config
    include StoreData

    def initialize
      file = "#{Dir.pwd}/data/config.yml"
      temp = load_file(file)
      @config = temp if temp.is_a?(Hash) && !temp.empty?
      setup_config if @config.nil?
      create_methods
    end

    private

    def setup_config
      @config = {}

      puts 'There is no config file, running the setup'
      puts 'Enter your discord token '
      @config[:discord_token] = gets.chomp

      puts 'Enter your discord client/application ID'
      @config[:discord_client_id] = gets.chomp

      puts 'Enter your google api key'
      @config[:google_api_key] = gets.chomp

      puts 'Enter owner id. Press enter for default (109268519115329536)'
      @config[:owner_id] = gets.chomp
      @config[:owner_id] = 109268519115329536 if @config[:owner_id].empty?

      puts 'Enter your prefix. Press enter for default ("!")'
      @config[:prefix] = gets.chomp
      @config[:prefix] = '!' if @config[:prefix].empty?

      puts 'Enter your permissions code. Press enter for default (66321471)'
      @config[:permissions_code] = gets.chomp
      @config[:permissions_code] = 66321471 if @config[:permissions_code].empty?

      puts 'Enable music bot features? (y/n)'
      @config[:music_bot] = if gets.chomp == 'y'
                              true
                            else
                              false
                            end

      save
    end

    def create_methods
      @config.keys.each do |key|
        self.class.send(:define_method, key) do
          @config[key]
        end
      end
    end

    def save
      save_to_file(@file, @config)
    end
  end
end
