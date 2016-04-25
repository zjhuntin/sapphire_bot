module SapphireBot
  module Events
    module ServerCreate
      module ConfigureServer
        extend Discordrb::EventContainer
        server_create do |event|
          unless event.bot.server_config.server_exists?(event.server.id)
            event.bot.server_config.create(event.server.id)
            event.server.default_channel.send_message("Howdy! It seems like I joined your server for the first time. Use  `#{CONFIG[:prefix]}about` and `#{CONFIG[:prefix]}help` or `#{CONFIG[:prefix]}help <command>` if you need anything.")
          end
        end
      end
    end
  end
end
