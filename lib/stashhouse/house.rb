require 'stashhouse/room'


module Stashhouse
	class House
		attr_accessor :rooms

		def initialize(r)
			generate(r)
		end

		def valid_room?(x, y, r)
			x >= 0 and x < r and y >= 0 and y < r
		end

		def floor_plan(current_location, thug_location, stash_location)
			s = ""
			@rooms.each_with_index  do |row, rownum|
					row.each_with_index  do |col, colnum|  
					s += "["
					s += "X" if rownum == current_location[:x] and colnum == current_location[:y]

					@rooms[rownum][colnum].contents.each do |c|
						s += "T" if c.is_a?(Thug)
						s += "S" if c.is_a?(Stash)
					end
					s += "]"
				end
					s += "\n"
			end
			s
		end

		def room_plan(x, y)
			s = ""
			@rooms[x][y].walls.each do |direction, wall|
				case direction
				when 'N'
				  s += "" #unless wall.door.nil?
				when 'S'
				  s += "_" #unless wall.door.nil? 
				when 'E'
				  s += "|" #unless wall.door.nil? 
				when 'W'
				  s += "|" #unless wall.door.nil?
				 else
				 	s += "|_|"
				end			
			end
			s
		end

		private

		def generate(r)
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