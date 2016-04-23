module SapphireBot
  module Commands
    module Roll
      extend Discordrb::Commands::CommandContainer
      command(:roll, description: 'Rolls a dice.', bucket: :default) do
        event << rand(1..6)
      end
    end
  end
end
