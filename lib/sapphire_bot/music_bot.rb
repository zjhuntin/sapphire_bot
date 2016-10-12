# For some dumb reason Rubocop asked me to comment here.
module SapphireBot
  # Load other MusicBot files.
  Dir["#{File.dirname(__FILE__)}/music_bot/*.rb"].each { |file| require file }

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
      format: :bestaudio
    }

    def self.delete_server(id)
      BOT.servers[id].delete_dir
    end

    def self.delete_files
      BOT.servers.each do |_id, server|
        server.music_player.delete_dir
      end
    end

    # Updates bot's game status with number of songs being played.
    def self.update_game_status
      servers_with_music_playing = BOT.voices.size
      SapphireBot::BOT.game = if servers_with_music_playing.positive?
                                "music on #{servers_with_music_playing} server#{'s' if servers_with_music_playing != 1}!"
                              else
                                false
                              end
    end
  end
end
