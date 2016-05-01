module SapphireBot
  module Commands
    module Invite
      extend Discordrb::Commands::CommandContainer
      command(:invite, description: 'Prints information about inviting this bot to your sever.',
                       bucket: :default) do |event|
        event << 'To invite me to your server, click on the link below and select server.'
        event << 'Only users with `manage server` permission are able to invite me.'
        event << SHORTENER.shorten(event.server, "#{event.bot.invite_url}+&permissions=#{CONFIG[:permissions_code]}")
      end
    end
  end
end
