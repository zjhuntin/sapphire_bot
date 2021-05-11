module SapphireBot
  # Module for sapphire commands.
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
      Announce,
      Delete,
      Flip,
      Invite,
      Lmgtfy,
      Roll,
      Stats,
      Ping,
      KickAll,
      About,
      Avatar,
      Eval,
      Toggle,
      Set,
      Default,
      Settings,
      Ignore,
      YoutubeSearch,
      MusicHelp,
      Join,
      Leave,
      Add,
      Queue,
      ClearQueue,
      Skip,
      Repeat,
      Download
    ]

    def self.include!
      @commands.each do |command|
        SapphireBot::BOT.include!(command)
      end
    end
  end
end
