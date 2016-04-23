require 'open-uri'

module SapphireBot
  module Commands
    module Eval
      extend Discordrb::Commands::CommandContainer
      command(:eval, bucket: :default, min_args: 1, usage: 'eval <code>',
                     description: 'Evaluates Ruby expression(s))') do |event, *code|
        if event.author.id == OWNER_ID
          code = code.join(' ').to_s
          begin
            event << eval(code)
            LOGGER.info "#{event.author.username} used eval command with the following code: #{code}."
          rescue => e
            event << 'Eval resulted in an error.'
            LOGGER.error "#{event.author.username} used eval command with the following code: #{code} and it resulted in an error."
            LOGGER.log_exception e
          end
          nil
        else
          event << 'Only bot owner can use this message.'
        end
      end
    end
  end
end
