module SapphireBot
  module Commands
    # Flips a coin and displays the result.
    module Flip
      extend Discordrb::Commands::CommandContainer
      command(:flip, description: 'Fips a coin.') do
        %w(Heads Tails).sample
      end
    end
  end
end
