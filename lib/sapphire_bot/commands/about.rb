module SapphireBot
  module Commands
    module About
      extend Discordrb::Commands::CommandContainer
      command(:about, bucket: :default,
                      description: 'Shows information about this bot.') do |event|
        event << ''
        event << 'Author: PoVa (<@109268519115329536>).'
        event << "Owner: <@#{CONFIG[:owner_id]}>."
        event << 'Discord: <https://goo.gl/KaNx9s>'
        event << 'Github: <https://goo.gl/iSUIhb>'
        event << "Version: #{VERSION}."
      end
    end
  end
end
