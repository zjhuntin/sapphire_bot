require 'google/apis/youtube_v3'
require 'google/apis/urlshortener_v1'

module SapphireBot
  class GoogleServices
    include StoreData
    include Helpers

    def initialize
      @youtube = Google::Apis::YoutubeV3::YouTubeService.new
      @shortener = Google::Apis::UrlshortenerV1::UrlshortenerService.new

      @shortener.key = CONFIG[:google_api_key]
      @youtube.key = CONFIG[:google_api_key]

      @ignored_urls = load_file("#{Dir.pwd}/data/ignored_urls.yml")
    end

    def find_video(query)
      result = @youtube.list_searches('snippet', q: query, type: 'video', max_results: 1).items.first
      return unless result
      STATS.stats_hash[:videos_found] += 1
      "https://youtu.be/#{result.id.video_id}"
    rescue => e
      LOGGER.log_exception e
      nil
    end

    def shorten_url(url)
      if !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) } &&
         valid_url?(url)
        url = Google::Apis::UrlshortenerV1::Url.new(long_url: url)
        url = @shortener.insert_url(url).id
        STATS.stats_hash[:urls_shortened] += 1
      end
      url

    rescue => e
      LOGGER.log_exception e
      url
    end

    # Can be called as shorten(event) if event is Discordrb::Events::MessageEvent
    #               or shorten(text)
    def shorten_text(var)
      if var.is_a?(Discordrb::Events::MessageEvent)
        text = var.message.content
      elsif var.is_a?(String)
        text = var
      end

      return text unless text || text.length > 21

      if text.include?(' ') || text.include?("\n")
        return text.lines.map do |line|
          line.split(' ').map do |word|
            shorten_url(word)
          end.join(' ')
        end.join("\n")
      end

      shorten_url(text)
    end
  end
end
