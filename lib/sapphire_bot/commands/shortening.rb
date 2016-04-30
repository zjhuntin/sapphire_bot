module SapphireBot
  module Commands
    module Shortening
      extend Discordrb::Commands::CommandContainer
      command(:shortening, description: 'Enables or disables automatic link shortening server-wide',
                           usage: 'shortening <on/off>',
                           required_permissions: [:manage_server],
                           bucket: :default, min_args: 1) do |event, option|
        if option == 'on'
          event.server.update_config(shortening: true)
          event << 'From now on, I will automatically shorten links.'
        elsif option == 'off'
          event.server.update_config(shortening: false)
          event << 'Automatic link shortening is now off.'
        else
          event << 'Unknown option, use on or off.'
        end
      end
    end
  end
end
