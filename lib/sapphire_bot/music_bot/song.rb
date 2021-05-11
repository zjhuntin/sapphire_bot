module SapphireBot
  module MusicBot
    # A class for a single song that. Used in SapphireBot::MusicBot::MusicPlayer.
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

        # People who have downloaded this song.
        @sent_to = []

        # People who are currently recieving this song.
        @sending_to = []
      end

      # Returns duration in proper format (01:02)
      def duration_formated
        seconds = @duration
        minutes = seconds / 60
        seconds -= minutes * 60
        "#{'0' if minutes < 10}#{minutes}:#{'0' if seconds < 10}#{seconds}"
      end

      # Deletes the song file if it can be deleted, or waits until it is and then deletes it.
      def delete
        if can_be_deleted?
          File.delete(@path)
        else
          Thread.new do
            while File.exist(@path)
              File.delete(@path) if can_be_deleted?
              sleep(10)
            end
          end
        end
      end

      # Returns information about the song.
      def inspect
        "\"#{@title}\" (#{duration_formated}) #{@url}"
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

      # TODO: Add more checks.
      def valid?
        @duration < MAX_SONG_LENGTH
      end

      def downloaded_by?(user)
        @sent_to.include?(user.id)
      end

      def send_to_user(user)
        @sending_to << user.id

        Thread.new { user.send_file(File.new(@path), inspect) }

        @sending_to.delete(user.id)
        @sent_to << user.id
      rescue
        @sending_to.delete(user.id) if @sending_to.include?(user.id)
      end

      def truncated_title
        if @title.length >= 15
          @title[0..15].chomp + '...'
        else
          @title
        end
      end

      private

      def can_be_deleted?
        @sending_to.empty?
      end
    end
  end
end
