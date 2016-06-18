module SapphireBot
  module Commands
    # Makes the bot disconnect from current voice channel.
    module Leave
      extend Discordrb::Commands::CommandContainer
      command(:leave, description: 'Makes the bot leave your voice channel.',
                      required_permissions: [:manage_server]) do |event|
        break unless event.voice

        event.voice.destroy
        event.server.queue.delete_dir
        LOGGER.debug "Music bot left #{event.channel.id}."
        nil
      end
    end
  end
end
