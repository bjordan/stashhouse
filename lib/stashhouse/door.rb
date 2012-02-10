module StashHouse
  class Door
    attr_accessor :locked

    def initialize
      @locked = false
    end

    def to_s
      "locked: #@locked"
    end
  end
end