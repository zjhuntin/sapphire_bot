module SapphireBot
  # Shortens links and finds videos from youtube.
  class GoogleServices
    include StoreData

    def initialize
      @youtube = Google::Apis::YoutubeV3::YouTubeService.new
      @shortener = Google::Apis::UrlshortenerV1::UrlshortenerService.new

      @shortener.key = CONFIG.google_api_key
      @youtube.key = CONFIG.google_api_key

      @ignored_urls = load_file("#{Dir.pwd}/data/ignored_urls.yml")
    end

    def find_video(query)
      result = @youtube.list_searches('snippet', q: query, type: 'video', max_results: 1).items.first
      return nil unless result
      STATS.videos_found += 1
      LOGGER.debug "Searched for video \"#{query}\" and found #{result.id.video_id}"
      result.id.video_id
    rescue => e
      LOGGER.log_exception e
      nil
    end

    # Detects urls in text and shortens them with goo.gl url shortener
    # Can be called as shorten(event) (if event is Discordrb::Events::MessageEvent
    #               or shorten(text, attributes)
    def shorten_text(var, preview: true, original: true, minlength: 21)
      if var.is_a?(Discordrb::Events::MessageEvent)
        text = var.message.content
        preview = var.server.preview if preview.nil?
        original = var.server.original if original.nil?
        minlength = var.server.minlength if minlength.nil?
      elsif var.is_a?(String)
        text = var
      end

      return text if !text || text.length < minlength

      shortened_text = text.clone

      URI.extract(text) do |url|
        next if url.length < minlength
        shortened_url = shorten_url(url)
        unless shortened_url == url
          shortened_url.insert(0, '<').insert(-1, '>') unless preview
          shortened_url.insert(0, "(#{url_host(url)}) ") if original
          shortened_text.gsub!(url, shortened_url)
        end
      end

      shortened_text
    end

    private

    def shorten_url(url)
      if !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        url_object = Google::Apis::UrlshortenerV1::Url.new(long_url: url)
        shortened_url = @shortener.insert_url(url_object).id
        STATS.urls_shortened += 1
        LOGGER.debug "Shortened \"#{url}\" to \"#{shortened_url}\""
      else
        return url
      end
      shortened_url
    rescue Google::Apis::ClientError
      url
    rescue => e
      LOGGER.log_exception e
      url
    end
  end
end
