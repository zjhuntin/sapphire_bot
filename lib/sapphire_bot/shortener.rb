require 'google_url_shortener'

module SapphireBot
  class Shortener
    def initialize
      Google::UrlShortener::Base.api_key = CONFIG[:googl_api]
      LOGGER.info 'google url shortener authorized'
    rescue => e
      LOGGER.log_exception e
    end

    def shorten(url, bot)
      bot.stats.urls_shortened += 1
      Google::UrlShortener.shorten!(url)
    end
  end
end
