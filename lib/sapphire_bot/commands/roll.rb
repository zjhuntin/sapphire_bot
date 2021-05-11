module SapphireBot
  module Commands
    # Flips a coin and displays the result.
    module Roll
      extend Discordrb::Commands::CommandContainer
      command(:roll, description: 'Rolls a dice.') do
        rand(1..6)
      end
    end
  end
end
