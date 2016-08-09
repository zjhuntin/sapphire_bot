module SapphireBot
  module MusicBot
    # A class for playing and managing music.
    class MusicPlayer
      # Loops current song if set to true.
      attr_accessor :repeat

      # Skips to the next song, even if repeat is set to true.
      attr_accessor :skip

      # Id of server.
      attr_reader :id

      # Whether music is currently being played.
      attr_reader :playing

      # Text channel that should be used for bot responses.
      attr_accessor :channel

      # Voice object that should be ued for playback.
      attr_accessor :voice

      # An array that holds songs.
      attr_reader :queue

      @@servers_with_music_playing = 0

      def initialize(id)
        @id = id
        @queue = []
        @repeat = false
        @skip = false
        @playing = false
        @server_dir = "#{Dir.pwd}/data/music_bot/#{id}"

        delete_dir if Dir.exist?(@server_dir)

        afk_timer
        game_status_loop
      end

      # Downloads the song and returns true if it succeeded.
      def add(video_id)
        song = Song.new(video_id, @server_dir)
        if valid_song?(song) && unique_song?(song)
          message = respond("Downloading \"#{song.title}\".")
          @queue << song
          if song.download
            message.delete
            true
          else
            message.delete
            @queue.delete(song)
            respond("There was a problem downloading \"#{song.title}\"")
            false
          end
        else
          false
        end
      end

      # Starts a loop, which plays the first song from queue if it's available, or waits until it is.
      def start_loop
        unless @playing || @queue.first.nil?
          @playing = true
          loop do
            LOGGER.debug "Started music loop for server #{@id}"
            if @queue.empty?
              respond('Music player is empty, add more songs with `add` command.')
              break
            end
            song = @queue.first
            play_song(song) if song.ready || wait_for_song(song)
          end
          @playing = false
        end
      end

      # Returns server queue table.
      def table
        Terminal::Table.new(headings: %w(# Name Duration Link)) do |t|
          @queue.each_with_index do |song, index|
            title = if song.title.length >= 15
                      song.title[0..15].chomp + '...'
                    else
                      song.title
                    end
            duration = song.duration_formated
            url = "<#{song.url}>"
            t.add_row([index + 1, title, duration, url])
          end
        end
      end

      # Deletes entire directory where songs are kept for this server.
      def delete_dir
        FileUtils.rm_rf(@server_dir)
        @queue = []
      end

      def delete_song_at(index)
        @queue[index].delete_file
        @queue.delete_at(index)
      end

      def playing?
        @playing
      end

      # Destroys voice connection and deletes all files. Informs the user if message is specified.
      def disconnect(message = nil)
        @voice.destroy
        delete_dir
        respond(message) if message
        @voice = nil
        @channel = nil
      rescue => e
        LOGGER.error 'An error occured while trying to leave a server.'
        LOGGER.log_exception e
      end

      private

      # Plays a song and keeps looping it if @repeat is set to true. Deletes it after it has finished.
      def play_song(song)
        message = respond("Playing \"#{song.title}\" (#{song.duration_formated}) #{song.url}")
        LOGGER.debug "Playing a song (#{song.inspect}), repeating: #{@repeat}"
        loop do
          @voice.play_file(song.path)
          STATS.songs_played += 1
          next if @repeat && !@skip
          @skip = false
          delete_first_song unless @queue.first.nil?
          message.delete
          break
        end
      end

      # Waits until song is available to play or returns false if it takes too long.
      def wait_for_song(song)
        retries = 0
        loop do
          LOGGER.debug "Waiting for song to be available on server #{@id} (#{song.inspect}) #{"(#{retries})" if retries > 0}"
          return true if song.ready
          if retries > 3
            LOGGER.debug "Song was not available after #{retries} retries on server #{@id}. (#{song.inspect})"
            return false
          end
          respond("\"#{song.title}\" is not ready yet, will start playing once it is.")
          retries += 1
          sleep(10)
        end
      end

      def delete_first_song
        delete_song(@queue.first)
      end

      # Finds a song in the queue and deletes it.
      def delete_song(song)
        @queue.find { |x| x == song }.delete_file
        @queue.delete(song)
      end

      # Checks if this song has already been added to the queue and inform the user if it has.
      def unique_song?(song)
        @queue.each do |song_from_queue|
          if song_from_queue.url == song.url
            respond('This song has already been added. Use `repeat` command to play songs multiple times.')
            return false
          end
        end
        true
      end

      # Checks if a song is valid and inform the user if it isn't.
      def valid_song?(song)
        if song.valid?
          true
        else
          respond("The song is too long. Maximum length is #{MAX_SONG_LENGTH} seconds.")
          false
        end
      end

      # Sends a message to the channel that is used for bot responses.
      def respond(message)
        @channel.send_message(message) if @channel
      end

      # Destroys voice connection after it has been inactive for more than 60 seconds.
      def afk_timer
        Thread.new do
          counter = 0
          loop do
            # Reset counter to zero if something started plaing or there is no voice connection.
            if @playing || @voice.nil?
              counter = 0
              sleep(10)
            else
              counter += 1
            end

            # Nothing was played for more than 60 seconds.
            if counter >= 6
              counter = 0
              disconnect("You haven't been playing anything for too long. Next time use `leave` command after you've finished.")
            else
              sleep(10)
            end
          end

          nil
        end
      end

      # Updates Bot's game status with number of songs being played.
      def game_status_loop
        Thread.new do
          # Make sure not to add of subtract multiple times.
          last_action = :subtracted

          loop do
            if @playing && last_action != :added
              @@servers_with_music_playing += 1
              last_action = :added
            elsif !@playing && last_action != :subtracted
              @@servers_with_music_playing -= 1
              last_action = :subtracted
            end

            BOT.game = if @@servers_with_music_playing > 0
                         "music on #{@@servers_with_music_playing} server#{'s' if @@servers_with_music_playing != 1}!"
                       else
                         false
                       end

            sleep(10)
          end
        end
      end
    end
  end
end
