module SapphireBot
  module Commands
    # Displays information about music bot.
    module MusicHelp
      extend Discordrb::Commands::CommandContainer
      command(:musichelp, description: 'Displays information on how to use music features.') do |event|
        event << 'To start using music bot a user with `manage server` permission has to invite it to a channel by using `join` command.'
        event << 'Then you can add songs by using `add` command.'
        event << 'Use `queue` command to see added songs.'
        event << 'Users with `manage server` permission can remove songs from queue by using `clearqueue <id>` command.'
        event << 'Each song will start playing automaticlly after the last one finishes.'
        event << "If you're not using music bot features anymore use `leave` command."
        event << 'You can find more help for each of these commands by using `help <commandname>` command.'
      end
    end
  end
end
