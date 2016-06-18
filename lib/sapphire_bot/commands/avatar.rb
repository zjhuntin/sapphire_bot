module SapphireBot
  module Commands
    # Sets avatar of a bot.
    module Avatar
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:avatar, usage: 'avatar <url>', min_args: 1,
                       description: 'Sets avatar of this bot.') do |event, url|
        break unless event.author.id == CONFIG.owner_id && valid_url?(url)

        event.bot.profile.avatar = open(url)
        'Avatar set!'
      end
    end
  end
end
