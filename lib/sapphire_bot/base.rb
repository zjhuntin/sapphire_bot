# Base module for sapphire
module SapphireBot
  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            application_id: CONFIG.discord_client_id,
                                            prefix: CONFIG.prefix,
                                            advanced_functionality: false)
  GOOGLE = GoogleServices.new
  STATS = Stats.new

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
