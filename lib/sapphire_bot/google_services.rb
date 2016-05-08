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
        url_object = Google::Apis::UrlshortenerV1::Url.new(long_url: url)
        shortened_url = @shortener.insert_url(url_object).id
        STATS.stats_hash[:urls_shortened] += 1
      end
      shortened_url

    rescue => e
      LOGGER.log_exception e
      url
    end

    # Can be called as shorten(event, preview) if event is Discordrb::Events::MessageEvent
    #               or shorten(text, preview)
    def shorten_text(var, preview = true)
      if var.is_a?(Discordrb::Events::MessageEvent)
        text = var.message.content
      elsif var.is_a?(String)
        text = var
      else
        return nil
      end

      return text if text || text.length > 21

      if text.include?(' ') || text.include?("\n")
        return text.lines.map do |line|
          line.split(' ').map do |word|
            if valid_url?(word)
              word = shorten_url(word)
              word.insert(0, '<').insert(-1, '>') unless preview
            end
            word
          end.join(' ')
        end.join("\n")
      elsif valid_url?(text)
        url = shorten_url(text)
        url.insert(0, '<').insert(-1, '>') unless preview
        return url
      end

      text
    end
  end
end
