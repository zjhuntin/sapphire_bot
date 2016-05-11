module SapphireBot
  module Commands
    module Roasted
      extend Discordrb::Commands::CommandContainer
      command(:roasted, description: 'Use when you roast somebody. Illegal in 73 countries.',
                        rate_limit_message: 'Woah woah woah, slowdown for %time% seconds.',
                        bucket: :voice) do |event|
        channel = event.user.voice_channel
        unless !channel || channel == event.server.afk_channel
          voice = event.bot.voice_connect(channel)

          voice.play_file("#{Dir.pwd}/data/voice_files/roasted.mp3")
          voice.destroy
        end

        nil
      end
    end
  end
end
