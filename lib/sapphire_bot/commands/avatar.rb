require 'open-uri'

module SapphireBot
  module Commands
    module Avatar
      extend Discordrb::Commands::CommandContainer
      command(:avatar, bucket: :default, usage: 'avatar <url>', min_args: 1,
                       description: 'Sets avatar of this bot.') do |event, url|
        if valid_url?(url)
          if event.author.id == CONFIG[:owner_id]
            event.bot.profile.avatar = open(url)
            event << 'Avatar set.'
          else
            event << 'Only bot owner can use this message.'
          end
        else
          event << 'Invalid url.'
        end
      end
    end
  end
end
