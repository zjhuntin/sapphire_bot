module SapphireBot
  module Commands
    module Shortening
      extend Discordrb::Commands::CommandContainer
      command(:shortening, description: 'Enables or disables automatic link shortening server-wide',
                           usage: 'shortening <on/off>',
                           bucket: :default, min_args: 1) do |event, option|
        if event.author.permission?(:manage_server, event.channel)
          if option == 'on'
            event.bot.server_config.update(event.server.id, :auto_shorten, true)
            event << 'From now on, I will automatically shorten links.'
          elsif option == 'off'
            event.bot.server_config.update(event.server.id, :auto_shorten, false)
            event << 'Automatic link shortening is now off.'
          else
            event << 'Unknown option, use on or off.'
          end
        else
          event << 'You need `manage server` permission to use this.'
        end
      end
    end
  end
end
