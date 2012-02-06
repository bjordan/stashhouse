require 'stashhouse/house'
require 'stashhouse/thug'
require 'stashhouse/stash'
require 'stashhouse/playa'
require 'stashhouse/scoreboard'

module StashHouse
  class Engine
    
    def initialize(num_rooms)     
      @num_rows = Math.sqrt(num_rooms)      
      
      @directions = ['N', 'S', 'E', 'W']
      @scoreboard = ScoreBoard.new
      @house = House.new(@num_rows)
      @rooms = @house.rooms

      @stash = Stash.new(["100 Red Tops", "200 Yellow Tops"])
      @thug = Thug.new("Slim Charles")
    end

    def init_player_locations
      @current_location = [@num_rows-1, rand(@num_rows)]
      @rooms[@current_location[0]][@current_location[1]].contents.push(@playa)

      @stash_location = [0,rand(@num_rows)]
      @rooms[@stash_location[0]][@stash_location[1]].contents.push(@stash)

      @thug_location = [(@num_rows / 2).ceil, rand(@num_rows)]
      @rooms[@thug_location[0]][@thug_location[1]].contents.push(@thug)
    end

    def start
      instructions = 'Enter direction, N(North), S(South), E(East) or W(West) (ENTER to exit)'
      p 'Whats yo name playa?'
      playa_name = STDIN.gets.chomp()
      @playa = Playa.new(playa_name)

      init_player_locations()  

      print_floorplan()

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
      # convert direction to next room coordinates
      x, y = *next_room_coords(direction, @current_location)

      # check if move is valid (not off the map)
      if @house.valid_room?(x, y)
        @rooms[@current_location[0]][@current_location[1]].contents.clear
        @rooms[x][y].contents.push(@playa)
        @current_location = [x, y]        
        game_status()
        move_thug()
        game_status()
        @playa.moves += 1
      else
        p 'You just walked into a wall dumb ass.' 
      end

      print_floorplan()
    end

    def valid_cardinal_direction?(direction)
      /^[N|S|E|W]$/i =~ direction
    end

    # recursive, only move one room at a time if the move is valid
    def move_thug
      next_direction = @directions[rand(@directions.size - 1)]
      
      x, y = *next_room_coords(next_direction, @thug_location)
 
      if @house.valid_room?(x, y)
        @rooms[@thug_location[0]][@thug_location[1]].contents.clear
        @rooms[x][y].contents.push(@thug)
        @thug_location = [x, y]
      else
        move_thug()
      end
    end

    # check if you encountered the thug or found the stash
    def game_status
      if stash_found?
        puts "You found the stash #{@stash}.\nNow get the hell outta there before #{@thug} smokes your ass."
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
      @stash_location[0] == @current_location[0] and @stash_location[1] == @current_location[1]
    end 

    def ass_smoked?
      @thug_location[0] == @current_location[0] and @thug_location[1] == @current_location[1]
    end 

    def print_floorplan
      print @house.floor_plan()
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

    def end_game
      @scoreboard.update(@playa)
      puts "#@scoreboard"
      Process.exit(1)
    end   
  end
end

s = StashHouse::Engine.new(16)
s.start
