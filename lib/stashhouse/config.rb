require 'yaml'

module StashHouse
  class Config
    def initialize
    end

    def self.load
      config = YAML.load_file('stashhouse/config.yml')
      [config['house_dimensions'][:rows], config['house_dimensions'][:cols], config[:num_thugs]]
    end
  end
end