require 'stashhouse/actor'

module StashHouse
  class Thug < Actor
    private_class_method :new

    @@THUG_NAMES = %w[Chris Snoop Slim Charles Marlow Stringer]
    @@NAME_INDEX = -1

    def initialize(name)
      super
    end

    # factory method
    def self.create
      @@NAME_INDEX += 1
      new(@@THUG_NAMES[@@NAME_INDEX])
    end

    def to_s
      "#@name #@location"
    end
  end
end