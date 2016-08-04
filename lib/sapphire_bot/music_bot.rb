module SapphireBot
  # Contains classes and information for music bot features.
  module MusicBot
    # Maximum length of a song in seconds.
    MAX_SONG_LENGTH = 600

    # Ammount of songs that can be added to queue at once.
    MAX_SONGS_IN_QUEUE = 15

    # Options that are used for YoutubeDL.rb
    DOWNLOAD_OPTIONS = {
      extract_audio: true,
      audio_format: 'mp3',
      format: :worst
    }

    def self.delete_server(id)
      BOT.servers[id].delete_dir
    end

    def self.delete_files
      BOT.servers.each do |_id, server|
        server.queue.delete_dir
      end
    end
  end
end
