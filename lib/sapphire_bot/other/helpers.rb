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
      return 'enabled' if bool
      'disabled'
    end

    def valid_url?(url)
      uri = URI.parse(url)
      return true if uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
      false
    rescue
      false
    end
  end
end
