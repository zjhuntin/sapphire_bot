module SapphireBot
  module Commands
    module YoutubeSearch
      extend Discordrb::Commands::CommandContainer
      command(:yt, description: 'Finds youtube videos.', min_args: 1,
                   usage: 'yt <query>') do |event, *query|
        video = 'https://youtu.be/' + GOOGLE.find_video(query.join(' '))
        event << if video
                   "**#{event.author.username}**: \"#{query.join(' ')}\" #{video}"
                 else
                   'Such video does not exist.'
                 end
        event.message.delete if event.bot.profile.on(event.server)
                                     .permission?(:manage_messages,
                                                  event.channel)
        nil
      end
    end
  end
end
