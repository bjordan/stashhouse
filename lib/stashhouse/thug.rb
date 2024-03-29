require_relative 'actor'

module StashHouse
  class Thug < Actor
    private_class_method :new

    @@THUG_NAMES = %w[Chris Snoop Slim Marlow Stringer]
    @@name_index = -1

    def initialize(name)
      super
    end

    # factory method
    def self.create
      @@name_index += 1
      new(@@THUG_NAMES[@@name_index])
    end

    def to_s
      "#@name #@location"
    end
  end
end