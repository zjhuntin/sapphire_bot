module SapphireBot
  module Commands
    module Flip
      extend Discordrb::Commands::CommandContainer
      command(:flip, description: 'Fips a coin.') do
        %w(Heads Tails).sample
      end
    end
  end
end
