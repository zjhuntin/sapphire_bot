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
      if !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        url_object = Google::Apis::UrlshortenerV1::Url.new(long_url: url)
        shortened_url = @shortener.insert_url(url_object).id
        STATS.stats_hash[:urls_shortened] += 1
      else
        return url
      end
      shortened_url

    rescue => e
      LOGGER.log_exception e
      url
    end
  end
end
