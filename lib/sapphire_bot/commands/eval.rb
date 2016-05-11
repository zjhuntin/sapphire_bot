module SapphireBot
  module Commands
    module Eval
      extend Discordrb::Commands::CommandContainer
      command(:eval, description: 'Evaluates Ruby expression(s)',
                     min_args: 1, usage: 'eval <code>') do |event, *code|
        if event.author.id == CONFIG[:owner_id]
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
        end
      end
    end
  end
end
