module SapphireBot
  module MusicBot
    class ServerQueue
      attr_accessor :repeat, :skip

      attr_reader :id, :queue, :playing

      def initialize(id)
        @id = id
        @queue = []
        @repeat = false
        @skip = false
        @playing = false
        @server_dir = "#{Dir.pwd}/data/music_bot/#{id}"

        delete_dir if Dir.exist?(@server_dir)
      end

      def add_to_queue(video_id, event)
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

      def delete_dir
        FileUtils.rm_rf(@server_dir)
        @queue = []
      end

      def delete_song_at(index)
        @queue[index].delete_file
        @queue.delete_at(index)
      end

      private

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

      def delete_song(song)
        @queue.find { |x| x == song }.delete_file
        @queue.delete(song)
      end
    end
  end
end
