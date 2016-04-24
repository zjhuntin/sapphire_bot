require 'google_url_shortener'

module SapphireBot
  class Shortener
    include StoreData
    def initialize
      @ignored_urls = load_file("#{Dir.pwd}/data/ignored_urls.yml")
      Google::UrlShortener::Base.api_key = CONFIG[:googl_api]
      LOGGER.info 'google url shortener authorized'
    rescue => e
      LOGGER.log_exception e
    end

    def shorten(url, bot)
      bot.stats.stats_hash[:urls_shortened] += 1
      unless @ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        return Google::UrlShortener.shorten!(url)
      end
      url
    end
  end
end
