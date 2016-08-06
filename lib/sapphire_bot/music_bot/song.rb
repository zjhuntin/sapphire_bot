module SapphireBot
  module MusicBot
    # A class for a single song that should be used in ServerQueue.
    class Song
      attr_reader :title, :duration, :path, :url, :ready, :valid

      def initialize(video_id, path)
        download_options = DOWNLOAD_OPTIONS.clone
        download_options[:output] = "#{path}/%(title)s-#{rand_string}.mp3"

        @youtube_dl = YoutubeDL::Video.new(video_id, download_options)

        @title = @youtube_dl.title
        @duration = @youtube_dl.duration
        @path = @youtube_dl.filename
        @url = "https://youtu.be/#{@youtube_dl.url}"
        @ready = false

        @valid = if @duration > MAX_SONG_LENGTH
                   false
                 else
                   true
                 end
      end

      # Returns duration in proper format (01:02)
      def duration_formated
        seconds = @duration
        minutes = seconds / 60
        seconds -= minutes * 60
        "#{'0' if minutes < 10}#{minutes}:#{'0' if seconds < 10}#{seconds}"
      end

      def delete_file
        File.delete(@path) if File.exist?(@path)
      end

      # Returns information about the song.
      def inspect
        "title: #{@title}, duration: #{@duration}, path: #{@path}, url: #{@url}"
      end

      def download
        @youtube_dl.download
      rescue => e
        LOGGER.log_exception e
        false
      else
        @ready = true
        true
      end
    end
  end
end
