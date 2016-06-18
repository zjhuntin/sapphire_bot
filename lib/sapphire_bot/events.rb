module SapphireBot
  # Module for sapphire events.
  module Events
    Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| require file }
  end
end
