module SapphireBot
  module ShortenText
    include Helpers
    def shorten_text(text, bot)
      return text if text.length <= 21
      if text.include?(' ')
        edited = false
        text = text.split(' ').map do |word|
          if valid_url?(word)
            edited = true
            bot.shortener.shorten(word, bot)
          else
            word
          end
        end.join(' ')
        return text if edited
      elsif valid_url?(text)
        return bot.shortener.shorten(text, bot)
      end
      text
    end
  end
end
