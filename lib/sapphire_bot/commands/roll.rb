module SapphireBot
  module Commands
    module Roll
      extend Discordrb::Commands::CommandContainer
      command(:roll, description: 'Rolls a dice.') do
        rand(1..6)
      end
    end
  end
end
