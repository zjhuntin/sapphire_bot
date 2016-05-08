module SapphireBot
  module Commands
    module Invite
      extend Discordrb::Commands::CommandContainer
      extend Helpers
      command(:invite, description: 'Prints information about inviting this bot to your sever.',
                       bucket: :default) do |event|
        event << 'To invite me to your server, click on the link below and select server.'
        event << 'Only users with `manage server` permission are able to invite me.'
        event << shorten_text("#{event.bot.invite_url}+&permissions=#{CONFIG[:permissions_code]}",
                              preview: event.server.preview?,
                              original: event.server.original?,
                              minlength: event.server.minlength)
      end
    end
  end
end
