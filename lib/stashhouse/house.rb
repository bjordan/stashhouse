require 'stashhouse/room'

module StashHouse
	class House
		attr_accessor :rooms, :rows

		def initialize(r)
			@rows = r
			build(r)
		end

		def valid_room?(x, y)
			x >= 0 and x < @rows and y >= 0 and y < @rows
		end

		def floor_plan
			s = "----------------------\n"
			s += "Stash House Floorplan\n"
			s += "---------------------\n"

			@rooms.each do |row|
				row.each do |room|
					s += '['
					room.contents.each do |c|
						s += 'T' if c.is_a?(Thug)
						s += 'S' if c.is_a?(Stash)
						s += 'X' if c.is_a?(Playa)
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

    def move_actor(from_coords, to_coords, actor)
       @rooms[from_coords[0]][from_coords[1]].contents.clear
       @rooms[to_coords[0]][to_coords[1]].contents.push(actor)
    end

		private

		def build(r)
			row, col = 0, 0
			# 3x3 grid map
			@rooms = []
			r.to_i.times { @rooms << Array.new(r.to_i) }

			# populate map with rooms
			1.upto(r**2) do |room_num|			
				@rooms[row][col] = Room.new(room_num)
				col += 1

				if room_num % r == 0
					row += 1
					col = 0
				end
			end
		end
	end
end