module SapphireBot
  module Commands
    module Game
      extend Discordrb::Commands::CommandContainer
      command(:game, description: 'Sets game status of the bot.',
                        usage: 'game <text>', min_args: 1,
                        bucket: :default) do |event, *text|
        event.bot.game = text.join(' ') if event.author.id == CONFIG[:owner_id]
        nil
      end
    end
  end
end
