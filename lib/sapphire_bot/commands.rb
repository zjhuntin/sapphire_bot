module SapphireBot
  # Module for sapphire commands.
  module Commands
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }
  end
end
