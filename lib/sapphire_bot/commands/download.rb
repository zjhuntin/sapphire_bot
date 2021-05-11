module SapphireBot
  module Commands
    # Downloads a song from music queue.
    module Download
      extend Discordrb::Commands::CommandContainer
      command(:download, description: 'Sents you the song from the music queue. Leave index empty if you want to download the songs that is currently being played.',
                         usage: 'download <index>') do |event, index|

        index = if index.nil?
                  0
                else
                  index.to_i - 1
                end

        song = event.server.music_player.queue[index]

        if song.nil?
          'Song with such index does not exist.'
        elsif !song.ready
          'The song is not ready yet. Try again once it is.'
        elsif song.downloaded_by?(event.author)
          "Yo, check your private messages, I've already sent you the song."
        else
          song.send_to_user(event.author)
          "#{event.author.mention} check your private message."
        end
      end
    end
  end
end
