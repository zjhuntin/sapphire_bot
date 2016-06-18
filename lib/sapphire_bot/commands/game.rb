module SapphireBot
  module Commands
    # Sets game status of a bot.
    module Game
      extend Discordrb::Commands::CommandContainer
      command(:game, description: 'Sets game status of the bot.',
                     usage: 'game <text>', min_args: 1) do |event, *text|
        break unless event.author.id == CONFIG.owner_id

        event.bot.game = text.join(' ')
        'Game status set!'
      end
    end
  end
end
