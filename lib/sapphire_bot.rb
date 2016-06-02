require 'uri'
require 'yaml'
require 'fileutils'

require 'google/apis/youtube_v3'
require 'google/apis/urlshortener_v1'
require 'discordrb'
require 'terminal-table'

require_relative 'sapphire_bot/logger'

debug = ARGV.include?('-debug') ? true : false
if debug
  Discordrb::LOGGER = SapphireBot::LOGGER = SapphireBot::Logger.new(:debug)
else
  Discordrb::LOGGER = SapphireBot::LOGGER = SapphireBot::Logger.new
end

require_relative 'sapphire_bot/version'
require_relative 'sapphire_bot/other/store_data'
require_relative 'sapphire_bot/other/helpers'
require_relative 'sapphire_bot/config'
require_relative 'sapphire_bot/server_config'

module SapphireBot
  CONFIG = Config.new

  require_relative 'sapphire_bot/stats'
  require_relative 'sapphire_bot/google_services'

  require_relative 'sapphire_bot/discordrb/server'

  Dir["#{File.dirname(__FILE__)}/sapphire_bot/commands/*.rb"].each { |file| require file }
  Dir["#{File.dirname(__FILE__)}/sapphire_bot/events/*.rb"].each { |file| require file }

  if CONFIG.music_bot
    require 'youtube-dl.rb'
    require_relative 'sapphire_bot/music_bot/song'
    require_relative 'sapphire_bot/music_bot/server_queue'
    require_relative 'sapphire_bot/music_bot/music_bot'
    Dir["#{File.dirname(__FILE__)}/sapphire_bot/music_bot/commands/*.rb"].each { |file| require file }
  end

  require_relative 'sapphire_bot/base'
end
