module SapphireBot
  module Helpers
    def time_in_words(time)
      days = (time / 86_400).to_i
      time -= days * 86_400
      hours = (time / 3600).to_i
      time -= hours * 3600
      minutes = (time / 60).to_i
      string = "#{days} day#{'s' unless days == 1},"
      string << " #{hours} hour#{'s' unless hours == 1},"
      string << " #{minutes} minute#{'s' unless minutes == 1}"
    end

    def bool_to_words(bool)
      return 'on' if bool
      'off'
    end

    # Can be called as shorten(event) if event is Discordrb::Events::MessageEvent
    #               or shorten(text, attributes)
    def shorten_text(var, attributes = {})
      if var.is_a?(Discordrb::Events::MessageEvent)
        text = var.message.content
        attributes[:preview] = var.server.preview? if attributes[:preview].nil?
        attributes[:original] = var.server.original? if attributes[:original].nil?
      elsif var.is_a?(String)
        text = var
        attributes[:preview] = true if attributes[:preview].nil?
        attributes[:original] = true if attributes[:original].nil?
      end

      return text if !text || text.length < 21

      shortened_text = text.clone

      URI.extract(text) do |url|
        shortened_url = GOOGLE.shorten_url(url)
        unless shortened_url == url
          shortened_url.insert(0, '<').insert(-1, '>') unless attributes[:preview]
          shortened_url.insert(0, "(#{url_host(url)}) ") if attributes[:original]
          shortened_text.gsub!(url, shortened_url)
        end
      end

      return shortened_text
    end

    def valid_url?(url)
      uri = URI.parse(url)
      return true if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      false
    rescue
      false
    end

    def url_host(url)
      URI.parse(url).host
    rescue
      nil
    end
  end
end
