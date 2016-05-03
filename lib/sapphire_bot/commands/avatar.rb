require 'open-uri'

module SapphireBot
  module Commands
    module Avatar
      extend Helpers
      extend Discordrb::Commands::CommandContainer
      command(:avatar, bucket: :default, usage: 'avatar <url>', min_args: 1,
                       description: 'Sets avatar of this bot.') do |event, url|
        event.bot.profile.avatar = open(url) if event.author.id == CONFIG[:owner_id] &&
                                                SHORTENER.valid_url?(url)
        nil
      end
    end
  end
end
