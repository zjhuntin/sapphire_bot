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

    def shorten_text(event, text = '')
      text = event.message.content if event.is_a?(Discordrb::Events::MessageEvent)
      return text if text.length <= 21
      if text.include?(' ') || text.include?("\n")
        return text.lines.map do |line|
          line.split(' ').map do |word|
            shorten(word, event)
          end.join(' ')
        end.join("\n")
      end
      shorten(text, event)
    end

    def shorten(url, event)
      if valid_url?(url) && !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        event.bot.stats.stats_hash[:urls_shortened] += 1
        return Google::UrlShortener.shorten!(url) if event.server.preview?
        return "<#{Google::UrlShortener.shorten!(url)}>"
      end
      url
    end
  end
end
