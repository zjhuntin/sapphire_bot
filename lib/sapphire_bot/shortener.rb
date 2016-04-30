require 'google_url_shortener'

module SapphireBot
  class Shortener
    include Helpers
    include StoreData

    def initialize
      @ignored_urls = load_file("#{Dir.pwd}/data/ignored_urls.yml")
      Google::UrlShortener::Base.api_key = CONFIG[:googl_api]
    rescue => e
      LOGGER.log_exception e
    end

    def shorten_text(text, bot)
      if text.length <= 21
        return text
      elsif text.include?(' ') || text.include?("\n")
        return text.lines.map do |line|
          line.split(' ').map do |word|
            bot.shortener.shorten(word, bot)
          end.join(' ')
        end.join("\n")
      end
      bot.shortener.shorten(text, bot)
    end

    def shorten(url, bot)
      bot.stats.stats_hash[:urls_shortened] += 1
      if valid_url?(url) && !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        return Google::UrlShortener.shorten!(url)
      end
      url
    end
  end
end
