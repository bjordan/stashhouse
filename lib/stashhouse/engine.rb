require 'stashhouse/house'
require 'stashhouse/thug'
require 'stashhouse/stash'

module Stashhouse
	class Engine
		
		def initialize(num_rooms)			
			@num_rows = Math.sqrt(num_rooms)
			@current_location = {:x => @num_rows - 1, :y => 0}
			
			@house = House.new(@num_rows)
			@rooms = @house.rooms

			@stash = Stash.new(["100 Red Tops", "200 Yellow Tops"])
			@stash_location = [0,0]

			@thug = Thug.new("Slim Charles")
			@thug_location = [0,0]
			
			move_playas()
		end

		def start
			instructions = 'Enter direction, N(North), S(South), E(East) or W(West) (ENTER to exit)'
			p instructions

			while true
				print '> '
				input = STDIN.gets.chomp()

				if input.empty?
					Process.exit(1)
				elsif valid_cardinal_direction?(input) 
					move(input.upcase)
				else	
					p instructions
				end
			end
		end

		def move(direction)
			# convert direction to next coordinates
			case direction
			when 'N'
			  x, y = @current_location[:x] - 1, @current_location[:y]
			when 'S'
			  x, y = @current_location[:x] + 1, @current_location[:y]
			when 'E'
			  x, y = @current_location[:x], @current_location[:y] + 1
			when 'W'
			  x, y = @current_location[:x], @current_location[:y] - 1
			end

			# check if move is valid (not off the map)
			if @house.valid_room?(x, y, @num_rows)
				@current_location[:x], @current_location[:y] = x, y
				game_status()
				move_playas()
			else
				p 'You just walked into a wall dumb ass.'	
			end

			print_floorplan()
		end

		def valid_cardinal_direction?(direction)
			/^[N|S|E|W]$/i =~ direction
		end

		def move_playas
			reset_room_contents()
			move_stash()
			move_thug()
		end

		def move_stash
			x, y = rand(@num_rows), rand(@num_rows)
			@rooms[x][y].contents.push(@stash)
			@stash_location = [x, y]
		end

		def move_thug
			x, y = rand(@num_rows), rand(@num_rows)
			@rooms[x][y].contents.push(@thug)
			@thug_location = [x, y]
		end

		def reset_room_contents
			[@thug_location, @stash_location].each { |i| @rooms[i[0]][i[1]].contents.clear() }
		end

 		# check if you encountered the thug or found the stash
		def game_status
			if stash_found?
				p "You found the stash. Now get the hell outta there before #{@thug} smokes your ass."
				print_floorplan()
				end_game()
			end				
			if ass_smoked?
				p "You got your ass smoked by #{@thug}."
				print_floorplan()
				end_game()
			end	
		end	

		def stash_found?
			@stash_location[0] == @current_location[:x] and @stash_location[1] == @current_location[:y]
		end	

		def ass_smoked?
			@thug_location[0] == @current_location[:x] and @thug_location[1] == @current_location[:y]
		end	

		def print_floorplan
			print @house.floor_plan(@current_location, @thug_location, @stash_location)
		end

		def end_game
			Process.exit(1)
		end		
	end
end

s = Stashhouse::Engine.new(9)
s.start
