module SapphireBot
  module Commands
    module Ignore
      extend Discordrb::Commands::CommandContainer
      command(:ignore, description: 'Makes the bot (un)ignore a user',
                       usage: 'ignore <@user>', min_args: 1) do |event, mention|
        if event.author.id == CONFIG.owner_id
          user = event.bot.parse_mention(mention)
          unless user
            event << 'Invalid user'
            break
          end
          if event.bot.ignored?(user)
            event.bot.unignore_user(user)
          else
            event.bot.ignore_user(user)
          end
          nil
        end
      end
    end
  end
end
