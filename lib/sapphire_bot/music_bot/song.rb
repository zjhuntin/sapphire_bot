module SapphireBot
  module MusicBot
    class Song
      attr_reader :title, :duration, :path, :url

      attr_accessor :ready

      def initialize(title, duration, path, url, ready = false)
        @title = title
        @duration = duration
        @path = path
        @url = "https://youtu.be/#{url}"
        @ready = ready
        LOGGER.debug "Initialized a new song (#{inspect})"
      end

      def duration_formated
        seconds = @duration
        minutes = seconds / 60
        seconds -= minutes * 60
        "#{'0' if minutes < 10}#{minutes}:#{'0' if seconds < 10}#{seconds}"
      end

      def delete_file
        File.delete(path) if File.exist?(path)
      end

      def inspect
        "title: #{@title}, duration: #{@duration}, path: #{@path}, url: #{@url}"
      end
    end
  end
end
