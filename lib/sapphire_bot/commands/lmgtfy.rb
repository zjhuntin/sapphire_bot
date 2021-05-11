module SapphireBot
  module Commands
    # Generates a lmgtfy link.
    module Lmgtfy
      extend Discordrb::Commands::CommandContainer
      command(:lmgtfy, min_args: 1,
                       description: 'Generates Let Me Goole That For You link.',
                       usage: 'lmgtfy <text>') do |event, *text|
        GOOGLE.shorten_text("http://lmgtfy.com/?q=#{text.join('+')}",
                            preview: event.server.preview,
                            original: event.server.original,
                            minlength: event.server.minlength)
      end
    end
  end
end
