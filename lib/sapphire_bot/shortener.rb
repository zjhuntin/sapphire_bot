require 'google_url_shortener'

module SapphireBot
  class Shortener
    def initialize
      Google::UrlShortener::Base.api_key = GOOGLE_API
      LOGGER.info 'google url shortener authorized'
    rescue => e
      LOGGER.log_exception e
    end

    def shorten(url)
      STATS.urls_shortened += 1
      Google::UrlShortener.shorten!(url)
    end
  end
end
