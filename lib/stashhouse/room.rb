require 'stashhouse/wall'

module StashHouse
  class Room
    attr_accessor :walls, :num_doors, :room_number, :contents

    def initialize(room_number)
      @room_number = room_number
      @num_doors = 0
      @contents = []
      @walls = {
        'N' => Wall.new,
        'S' => Wall.new,
        'E' => Wall.new,
        'W' => Wall.new
      }
    end
  end
end