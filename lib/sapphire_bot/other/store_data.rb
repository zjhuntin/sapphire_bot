require 'yaml'

module SapphireBot
  module StoreData
    def save_to_file(file, object)
      File.open(file, 'w') do |f|
        f.write YAML.dump(object)
      end
    end

    def load_file(file)
      return YAML.load_file(file) if File.exist?(file)
      {}
    end
  end
end
