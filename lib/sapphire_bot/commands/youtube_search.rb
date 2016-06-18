module SapphireBot
  module Commands
    # Finds youtube videos by given query.
    module YoutubeSearch
      extend Discordrb::Commands::CommandContainer
      command(:yt, description: 'Finds youtube videos.', min_args: 1,
                   usage: 'yt <query>') do |event, *query|
        video = 'https://youtu.be/' + GOOGLE.find_video(query.join(' '))
        if video
          "**#{event.author.username}**: #{video}"
        else
          'Such video does not exist.'
        end
      end
    end
  end
end
