module SapphireBot
  module Commands
    # Ignores or unignores a user.
    module Ignore
      extend Discordrb::Commands::CommandContainer
      command(:ignore, description: 'Makes the bot (un)ignore a user.',
                       usage: 'ignore <@user>', min_args: 1) do |event, mention|
        break unless event.author.id == CONFIG.owner_id

        user = event.bot.parse_mention(mention)
        next 'Invalid user!' unless user
        if event.bot.ignored?(user)
          event.bot.unignore_user(user)
        else
          event.bot.ignore_user(user)
        end
      end
    end
  end
end
