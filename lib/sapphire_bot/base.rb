# Base module for sapphire
module SapphireBot
  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.discord_token,
                                            application_id: CONFIG.discord_client_id,
                                            prefix: CONFIG.prefix,
                                            advanced_functionality: false)
  GOOGLE = GoogleServices.new
  STATS = Stats.new

  BOT.include! Commands::Announce
  BOT.include! Commands::Delete
  BOT.include! Commands::Flip
  BOT.include! Commands::Invite
  BOT.include! Commands::Lmgtfy
  BOT.include! Commands::Roll
  BOT.include! Commands::Stats
  BOT.include! Commands::Ping
  BOT.include! Commands::KickAll
  BOT.include! Commands::About
  BOT.include! Commands::Avatar
  BOT.include! Commands::Eval
  BOT.include! Commands::Toggle
  BOT.include! Commands::Set
  BOT.include! Commands::Default
  BOT.include! Commands::Settings
  BOT.include! Commands::Game
  BOT.include! Commands::Ignore
  BOT.include! Commands::YoutubeSearch
  BOT.include! Commands::MusicHelp
  BOT.include! Commands::Join
  BOT.include! Commands::Leave
  BOT.include! Commands::Add
  BOT.include! Commands::Queue
  BOT.include! Commands::ClearQueue
  BOT.include! Commands::Skip
  BOT.include! Commands::Repeat

  BOT.include! Events::Mention
  BOT.include! Events::MessagesReadStat
  BOT.include! Events::AutoShorten
  BOT.include! Events::MassMessage
  BOT.include! Events::ReadyMessage

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
