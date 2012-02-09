module StashHouse
  class Stash
    attr_accessor :contents, :location

    def initialize(contents)
      @contents = contents
      @location = [0, 0]
    end

    def to_s
      "#@contents #@location"
    end
  end
end