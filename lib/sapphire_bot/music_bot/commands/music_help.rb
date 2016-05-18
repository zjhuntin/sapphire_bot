module SapphireBot
  module MusicBot
    module Commands
      module MusicHelp
        extend Discordrb::Commands::CommandContainer
        command(:musichelp, description: 'Displays information on how to use music features.') do |event|
          event << 'To start using music bot a user with `manage server` permission has to invite it to a channel by using `join` command.'
          event << 'Then you can to add songs to queue by using `add` command.'
          event << 'Use `queue` command to see song in current queue.'
          event << 'Users with `manage server` permission can remove songs from queue by using `clearqueue <id>` command.'
          event << 'Each song will start playing automaticlly after the last one finishes.'
          event << "If you're not using music bot features anymore use `leave` command."
          event << 'You can find more help for each of these commands by using `help <commandname>` command.'

          event << "This feature is in very early stage, please don't abuse it (or limitations will be implemented)."
          event << 'If you find any bugs please report them.'
        end
      end
    end
  end
end
