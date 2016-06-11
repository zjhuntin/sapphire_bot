require 'uri'
require 'yaml'
require 'fileutils'

require 'google/apis/youtube_v3'
require 'google/apis/urlshortener_v1'
require 'discordrb'
require 'terminal-table'

require_relative 'sapphire_bot/logger'

# Supresses warning: already initialized constant Discordrb::LOGGER

original_verbosity = $VERBOSE
$VERBOSE = nil

debug = ARGV.include?('-debug') ? true : false
Discordrb::LOGGER = LOGGER = if debug
                               SapphireBot::Logger.new(:debug)
                             else
                               SapphireBot::Logger.new
                             end

$VERBOSE = original_verbosity

# Requires logger

require_relative 'sapphire_bot/version'
require_relative 'sapphire_bot/other/helpers'
require_relative 'sapphire_bot/other/store_data'

# Requires store_data

require_relative 'sapphire_bot/stats'
require_relative 'sapphire_bot/server_config'
require_relative 'sapphire_bot/config'

CONFIG = SapphireBot::Config.new

# Requires config

require_relative 'sapphire_bot/google_services'

Dir["#{File.dirname(__FILE__)}/sapphire_bot/commands/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/sapphire_bot/events/*.rb"].each { |file| require file }

if CONFIG.music_bot
  require 'youtube-dl.rb'
  require_relative 'sapphire_bot/music_bot/song'
  require_relative 'sapphire_bot/music_bot/server_queue'
  require_relative 'sapphire_bot/music_bot/music_bot'
  Dir["#{File.dirname(__FILE__)}/sapphire_bot/music_bot/commands/*.rb"].each { |file| require file }
end

# Requires server_config

require_relative 'discordrb/server'

require_relative 'sapphire_bot/base'
