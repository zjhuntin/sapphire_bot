require 'google_url_shortener'

module SapphireBot
  class Shortener
    include StoreData

    def initialize
      @ignored_urls = load_file("#{Dir.pwd}/data/ignored_urls.yml")
      Google::UrlShortener::Base.api_key = CONFIG[:googl_api]
    rescue => e
      LOGGER.log_exception e
    end

    #Can be called as shorten(event) if event is Discordrb::Events::MessageEvent or
    #                 shorten(event.server, text)
    def shorten(var, text = '')
      if var.is_a?(Discordrb::Events::MessageEvent)
        text = var.message.content
        server = var.server
      elsif var.is_a?(Discordrb::Server)
        server = var
      end

      return text unless text || server || text.length > 21

      if text.include?(' ') || text.include?("\n")
        return text.lines.map do |line|
          line.split(' ').map do |word|
            shorten_url(server, word)
          end.join(' ')
        end.join("\n")
      end
      shorten_url(server, text)
    end

    def valid_url?(url)
      url =~ /\A#{URI.regexp}\z/
    end

    private

    def shorten_url(server, url)
      if valid_url?(url) && !@ignored_urls.any? { |ignored_url| url.include?(ignored_url) }
        STATS.stats_hash[:urls_shortened] += 1
        return Google::UrlShortener.shorten!(url) if server.preview?
        return "<#{Google::UrlShortener.shorten!(url)}>"
      end
      url
    end
  end
end
