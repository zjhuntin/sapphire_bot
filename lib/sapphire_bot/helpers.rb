require 'uri'

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

    def valid_url?(url)
      url =~ /\A#{URI.regexp}\z/
    end
  end
end
