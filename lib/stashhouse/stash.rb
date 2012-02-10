module StashHouse
  class Stash
    attr_accessor :contents, :location

    def initialize(contents)
      raise ArgumentError unless contents.is_a? Array
      
      @contents = contents
      @location = [0, 0]
    end

    def to_s
      "#@contents #@location"
    end
  end
end