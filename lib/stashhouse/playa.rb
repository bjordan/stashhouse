require_relative 'actor'

module StashHouse
  class Playa < Actor
    attr_accessor :moves

    def initialize(name)
      super
      @moves = 0
    end

    def to_s
      "#@name #@location #@moves"
    end
  end
end