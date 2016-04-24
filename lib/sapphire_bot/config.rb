require 'yaml'

module SapphireBot
  extend StoreData
  file = "#{Dir.pwd}/data/config.yml"
  temp = load_file(file)
  CONFIG = temp if temp
  unless defined?(CONFIG)
    config = {}

    puts 'There is no config file, running the setup'
    puts 'Enter your discord token '
    config[:discord_token] = gets.chomp

    puts 'Enter your discord id '
    config[:discord_id] = gets.chomp

    puts 'Enter your google api key '
    config[:googl_api] = gets.chomp

    puts 'Enter owner id. Press enter for default (109268519115329536)'
    config[:owner_id] = gets.chomp
    config[:owner_id] = 109268519115329536 if config[:owner_id].empty?

    puts 'Enter your prefix. Press enter for default ("!")'
    config[:prefix] = gets.chomp
    config[:prefix] = '!' if config[:prefix].empty?

    puts 'Enter your permissions code. Press enter for default (66321471)'
    config[:permissions_code] = gets.chomp
    config[:permissions_code] = 66321471 if config[:permissions_code].empty?

    save_to_file(file, config)
    CONFIG = config
  end
end
