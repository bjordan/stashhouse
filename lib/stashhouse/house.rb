require 'stashhouse/room'

module StashHouse
  class House
    attr_accessor :rooms, :rows

    def initialize(rows, cols)
      @rows = rows
      @cols = cols
      build()
    end

    def valid_room?(x, y)
      x >= 0 and x < @rows and y >= 0 and y < @cols
    end

    def floor_plan
      s = "----------------------\n"
      s += "Stash House Floorplan\n"
      s += "---------------------\n"

      @rooms.each do |row|
        row.each do |room|
          s += '['
          s += ' ' if room.contents.empty?
          room.contents.each do |c|
            s += 'T' if c.is_a?(Thug)
            s += 'S' if c.is_a?(Stash)
            s += 'P' if c.is_a?(Playa)
          end
          s += ']'
        end
        s += "\n"
      end
      s
    end

    def next_room_coords(direction, current_coords)
      case direction
      when 'N'
        x, y = current_coords[0] - 1, current_coords[1]
      when 'S'
        x, y = current_coords[0] + 1, current_coords[1]
      when 'E'
        x, y = current_coords[0], current_coords[1] + 1
      when 'W'
        x, y = current_coords[0], current_coords[1] - 1
      end      
    end

    def move_actor(actor, to_coords)
      # there may be more than 1 actor in the room. If names are equal(eql?) then delete.
      @rooms[actor.location[0]][actor.location[1]].contents.delete_if { |i| i.eql?(actor) }
      @rooms[to_coords[0]][to_coords[1]].contents.push(actor)
    end

    def in_same_room?(content, playa)
      content.location[0] == playa.location[0] and content.location[1] == playa.location[1]
    end

    private

    def build
      row, col = 0, 0
      # 3x3 grid map
      @rooms = []
      @rows.to_i.times { @rooms << Array.new(@cols.to_i) }

      # populate map with rooms
      1.upto(@rows * @cols) do |room_num|      
        @rooms[row][col] = Room.new(room_num)
        col += 1

        if room_num % @rows == 0
          row += 1
          col = 0
        end
      end
    end
  end
end