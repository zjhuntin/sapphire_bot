module SapphireBot
  module Commands
    # Makes the bot a join voice channel.
    module Join
      extend Discordrb::Commands::CommandContainer
      command(:join, description: 'Makes the bot join your voice channel.',
                     required_permissions: [:manage_server]) do |event|
        channel = event.user.voice_channel
        if !channel || channel == event.server.afk_channel
          next 'First join a valid voice channel.'
        end
        event.bot.voice_connect(channel)
        event.voice.encoder.use_avconv = true
        LOGGER.debug "Music bot joined #{event.channel.id}."
        "Joined \"#{channel.name}\". Use `add` command if you want toadd songs to queue."
      end
    end
  end
end
