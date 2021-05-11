module SapphireBot
  module Commands
    # Evaluates ruby expression
    module Eval
      extend Discordrb::Commands::CommandContainer
      command(:eval, min_args: 1, usage: 'eval <code>') do |event, *code|
        break unless event.author.id == CONFIG.owner_id
        code = code.join(' ').to_s
        begin
          event << eval(code)
          LOGGER.info "#{event.author.username} used eval command with the following code: #{code}."
        rescue => e
          event << 'Eval resulted in an error.'
          LOGGER.error "#{event.author.username} used eval command with the following code: #{code} and it resulted in an error."
          LOGGER.log_exception e
          nil
        end
      end
    end
  end
end
