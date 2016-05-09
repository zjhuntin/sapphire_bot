module SapphireBot
  STATS = Stats.new
  GOOGLE = GoogleServices.new

  bot = Discordrb::Commands::CommandBot.new(token: CONFIG[:discord_token],
                                            application_id: CONFIG[:discord_client_id],
                                            prefix: CONFIG[:prefix],
                                            advanced_functionality: false)

  LOGGER.info "oauth url: #{bot.invite_url}+&permissions=#{CONFIG[:permissions_code]}"

  bot.bucket(:default, limit: 5,
                       time_span: 30,
                       delay: 1)

  bot.include! Commands::Announce
  bot.include! Commands::Delete
  bot.include! Commands::Flip
  bot.include! Commands::Invite
  bot.include! Commands::Lmgtfy
  bot.include! Commands::Roll
  bot.include! Commands::Stats
  bot.include! Commands::Ping
  bot.include! Commands::KickAll
  bot.include! Commands::Leave
  bot.include! Commands::About
  bot.include! Commands::Avatar
  bot.include! Commands::Eval
  bot.include! Commands::Toggle
  bot.include! Commands::Set
  bot.include! Commands::Default
  bot.include! Commands::Settings
  bot.include! Commands::Game
  bot.include! Commands::Ignore
  bot.include! Commands::YoutubeSearch
  bot.include! Events::Mention
  bot.include! Events::Message::MessagesReadStat
  bot.include! Events::Message::AutoShorten
  bot.include! Events::Pm::MassMessage

  bot.run :async

  loop do
    STATS.update(bot)
    STATS.save
    STATS.inspect
    ServerConfig.save
    sleep(60)
  end
end
