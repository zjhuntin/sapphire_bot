require 'discordrb'

require_relative 'sapphire_bot/logger'

Discordrb::LOGGER = LOGGER = SapphireBot::Logger.new

require_relative 'sapphire_bot/version'
require_relative 'sapphire_bot/other/store_data'
require_relative 'sapphire_bot/other/helpers'

require_relative 'sapphire_bot/config'
require_relative 'sapphire_bot/server_config'

require_relative 'sapphire_bot/stats'
require_relative 'sapphire_bot/google_services'

require_relative 'sapphire_bot/discordrb/server'

Dir["#{File.dirname(__FILE__)}/sapphire_bot/commands/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/sapphire_bot/events/*.rb"].each { |file| require file }

require_relative 'sapphire_bot/base'
