require 'stashhouse/actor'

module StashHouse
  class Thug < Actor

    @@thug_names = ['Body', 'Snoop', 'Slim Charles', 'Poot']

    def initialize(name)
      super
    end

    # factory method
    def self.create
      Thug.new(@@thug_names[rand(@@thug_names.length - 1)])
    end

    def to_s
      "#@name #@location"
    end
  end
end