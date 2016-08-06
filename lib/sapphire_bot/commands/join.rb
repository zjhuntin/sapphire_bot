module SapphireBot
  module Commands
    # Makes the bot a join voice channel.
    module Join
      extend Discordrb::Commands::CommandContainer
      command(:join, description: 'Makes the bot join your voice channel.',
                     required_permissions: [:manage_server]) do |event|
        channel = event.user.voice_channel

        # Check if channel is valid.
        if !channel || channel == event.server.afk_channel
          next 'First join a valid voice channel.'
        end

        # Try to join the voice channel.
        begin
          event.bot.voice_connect(channel)
          event.voice.encoder.use_avconv = true
        rescue Discordrb::Errors::NoPermission
          next 'Please make sure I have permission to join this channel and try again.'
        end

        # Set voice object that should be used for playback.
        event.server.queue.voice = event.voice

        # Set channel that should be used for bot responses.
        event.server.queue.channel = event.channel

        LOGGER.debug "Music bot joined #{event.channel.id}."
        "Joined \"#{channel.name}\". Use `add` command if you want toadd songs to queue."
      end
    end
  end
end
