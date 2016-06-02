module SapphireBot
  module MusicBot
    module Commands
      module Join
        extend Discordrb::Commands::CommandContainer
        command(:join, description: 'Makes the bot join your voice channel.',
                       required_permissions: [:manage_server]) do |event|
          channel = event.user.voice_channel
          unless !channel || channel == event.server.afk_channel
            event.bot.voice_connect(channel)
            event.voice.encoder.use_avconv = true
            event << "Joined \"#{channel.name}\". You can now add songs to queue with `add` command."
            LOGGER.debug "Music bot joined #{event.channel.id}."
          end
          nil
        end
      end
    end
  end
end
