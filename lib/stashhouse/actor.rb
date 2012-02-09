module StashHouse
  class Actor
    attr_accessor :name, :location

    def initialize(name)
      @name = name
      @location = [0, 0]
    end

    def eql?(o)
      o.name == @name
    end
  end
end