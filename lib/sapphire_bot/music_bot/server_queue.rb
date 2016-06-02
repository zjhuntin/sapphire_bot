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
        @download_options = {
          extract_audio: true,
          audio_format: 'mp3',
          format: :worst,
          output: "#{@server_dir}/%(title)s.mp3"
        }

        delete_dir if Dir.exist?(@server_dir)
      end

      def download_song(video_id, event)
        song = YoutubeDL::Video.new(video_id, @download_options)

        if song.duration >= MAX_SONG_LENGTH
          event.respond("Song \"#{song.title}\" is longer than allowed (#{MAX_SONG_LENGTH}s).")
          return
        else
          if song.duration >= MAX_SONG_LENGTH / 2
            event.respond("Downloading \"#{song.title}\", this might take a while.")
          else
            event.respond("Downloading \"#{song.title}\".")
          end
          song_object = Song.new(song.title, song.duration,
                                 song.filename, song.url)
          @queue << song_object
          LOGGER.debug "Downloading a song for server #{@id}. #{song_object.inspect}"
          song.download
          @queue.find { |x| x == song_object }.ready = true
          LOGGER.debug "Song downloaded succesfully for server #{@id}. #{song_object.inspect}"
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
        event.respond("Playing \"#{song.title}\" (#{song.duration}) #{song.url}")
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
