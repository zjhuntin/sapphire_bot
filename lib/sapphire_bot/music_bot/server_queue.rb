module SapphireBot
  module MusicBot
    # A class that keeps track of server queue.
    class ServerQueue
      # Loops current song if set to true.
      attr_accessor :repeat

      # Skips to the next song, even if repeat is set to true.
      attr_accessor :skip

      # Id of server.
      attr_reader :id

      # Whether music is currently being played..
      attr_reader :playing

      def initialize(id)
        @id = id
        @queue = []
        @repeat = false
        @skip = false
        @playing = false
        @server_dir = "#{Dir.pwd}/data/music_bot/#{id}"

        delete_dir if Dir.exist?(@server_dir)
      end

      # Downloads the song and returns true if it succeeded.
      def add(video_id, event)
        song = Song.new(video_id, @server_dir)
        if song.valid
          event.respond("Downloading \"#{song.title}\".")
          @queue << song
          if song.download
            true
          else
            @queue.delete(song)
            event.respond("There was a problem downloading \"#{song.title}\"")
            false
          end
        else
          event.respond("The song is too long. Maximum length is #{MAX_SONG_LENGTH} seconds.")
          false
        end
      end

      # Starts a loop, which plays the first song from queue if it's available, or waits until it is.
      def start_loop(event)
        unless @playing || @queue.first.nil?
          @playing = true
          loop do
            LOGGER.debug "Started music loop for server #{@id}"
            if @queue.empty?
              event.respond('Queue is empty, add more songs with `add` command.')
              break
            end
            song = @queue.first
            play_song(song, event) if song.ready || wait_for_song(song, event)
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

      # Returns length of the queue
      def length
        @queue.length
      end

      # Check if queue is empty
      def empty?
        @queue.empty?
      end

      private

      # Plays a song and keeps looping it if @repeat is set to true. Deletes it after it has finished.
      def play_song(song, event)
        event.respond("Playing \"#{song.title}\" (#{song.duration_formated}) #{song.url}")
        LOGGER.debug "Playing a song (#{song.inspect}), repeating: #{@repeat}"
        loop do
          event.voice.play_file(song.path)
          STATS.songs_played += 1
          next if @repeat && !@skip
          @skip = false
          delete_first_song
          break
        end
      end

      # Waits until song is available to play or returns false if it takes too long.
      def wait_for_song(song, event)
        retries = 0
        loop do
          LOGGER.debug "Waiting for song to be available on server #{@id} (#{song.inspect}) #{"(#{retries})" if retries > 0}"
          return true if song.ready
          if retries > 3
            LOGGER.debug "Song was not available after #{retries} retries on server #{@id}. (#{song.inspect})"
            return false
          end
          event.respond("\"#{song.title}\" is not ready yet, will start playing once it is.")
          retries += 1
          sleep(10)
        end
      end

      def delete_first_song
        delete_song(@queue.first)
      end

      # Finds the song in queue and deletes it.
      def delete_song(song)
        @queue.find { |x| x == song }.delete_file
        @queue.delete(song)
      end
    end
  end
end
