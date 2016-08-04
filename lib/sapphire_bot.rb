require 'uri'
require 'yaml'
require 'fileutils'
require 'open-uri'

# Gems.
require 'google/apis/youtube_v3'
require 'google/apis/urlshortener_v1'
require 'discordrb'
require 'terminal-table'
require 'youtube-dl.rb'

require_relative 'sapphire_bot/logger'

# Supresses warning: already initialized constant Discordrb::LOGGER.
original_verbosity = $VERBOSE
$VERBOSE = nil

# Set debug mode if command line arguments include "-debug".
debug = ARGV.include?('-debug') ? true : false
Discordrb::LOGGER = SapphireBot::LOGGER = if debug
                                            SapphireBot::Logger.new(:debug)
                                          else
                                            SapphireBot::Logger.new
                                          end

$VERBOSE = original_verbosity

require_relative 'sapphire_bot/other/helpers'
require_relative 'sapphire_bot/other/store_data'
require_relative 'sapphire_bot/config'
require_relative 'sapphire_bot/music_bot'

SapphireBot::CONFIG = SapphireBot::Config.new

Dir["#{File.dirname(__FILE__)}/sapphire_bot/*.rb"].each { |file| require file }

require_relative 'discordrb/server'

module SapphireBot

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            application_id: CONFIG.discord_client_id,
                                            prefix: CONFIG.prefix,
                                            advanced_functionality: false)
  GOOGLE = GoogleServices.new
  STATS = Stats.new

  # See lib/commands.rb and lib/events.rb.
  Commands.include!
  Events.include!

  at_exit do
    LOGGER.info "Saving files and deleting songs before exiting..."
    STATS.save
    ServerConfig.save
    MusicBot.delete_files
    exit!
  end

  LOGGER.info "Oauth url: #{BOT.invite_url}+&permissions=#{CONFIG.permissions_code}"
  LOGGER.info "Use ctrl+c to safely stop the bot."
  BOT.run
end
