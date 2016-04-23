require 'yaml'

module SapphireBot
  file = "#{Dir.pwd}/config.yml"
  config = {}

  if File.exist?(file)
    begin
      config = YAML.load_file(file)
    rescue => e
      LOGGER.log_exeption e
    end
  else
    puts "There is no config file, running the setup"
    puts "Enter your discord token "
    config[:discord_token] = gets.chomp

    puts "Enter your discord id "
    config[:discord_id] = gets.chomp

    puts "Enter your google api key "
    config[:googl_api] = gets.chomp

    puts 'Enter owner id. Enter for default (109268519115329536)'
    config[:owner_id] = gets.chomp
    config[:owner_id] = 109268519115329536 if config[:owner_id].empty?

    puts 'Enter your prefix. Enter for default ("!")'
    config[:prefix] = gets.chomp
    config[:prefix] = "!" if config[:prefix].empty?

    puts 'Enter your permissions code. Enter for default (66321471)'
    config[:permissions_code] = gets.chomp
    config[:permissions_code] = 66321471 if config[:permissions_code].empty?

    File.open(file, 'w') do |f|
      f.write config.to_yaml
    end
  end
  CONFIG = config
end
