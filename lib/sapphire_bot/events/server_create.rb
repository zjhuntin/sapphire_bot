module SapphireBot
  module Events
    module ServerCreate
      module ConfigureServer
        extend Discordrb::EventContainer
        server_create do |event|
          event.bot.server_config.create(event.server.id)
        end
      end
    end
  end
end
