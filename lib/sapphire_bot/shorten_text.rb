module SapphireBot
  module ShortenText
    include Helpers
    def shorten_text(text)
      return text if text.length <= 21
      if text.include?(' ')
        edited = false
        text = text.split(' ').map do |word|
          if valid_url?(word)
            edited = true
            SHORTENER.shorten(word)
          else
            word
          end
        end.join(' ')
        return text if edited
      elsif valid_url?(text)
        return SHORTENER.shorten(text)
      end
      text
    end
  end
end
