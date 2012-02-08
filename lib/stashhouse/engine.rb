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

      @stash = Stash.new(["100 Red Tops", "200 Yellow Tops"])
      @thugs = [Thug.create(), Thug.create()]
    end

    def init_actor_locations
      @playa.location = [@num_rows-1, rand(@num_rows)]
      @house.rooms[@playa.location[0]][@playa.location[1]].contents.push(@playa)

      @stash_location = [0,rand(@num_rows)]
      @house.rooms[@stash_location[0]][@stash_location[1]].contents.push(@stash)

      @thugs.each do |thug|
        thug.location = [(@num_rows / 2).ceil, rand(@num_rows)]
        @house.rooms[thug.location[0]][thug.location[1]].contents.push(thug)
      end
    end

    def start
      instructions = 'Enter direction, N(North), S(South), E(East) or W(West) (ENTER to exit)'
      p 'Whats yo name playa?'
      playa_name = STDIN.gets.chomp()
      @playa = Playa.new(playa_name)

      init_actor_locations()  

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
      x, y = *@house.next_room_coords(direction, @playa.location)

      # check if move is valid (not off the map)
      if @house.valid_room?(x, y)
        @house.move_actor(@playa.location, [x, y], @playa)
        @playa.location = [x, y]
        game_status()
        move_thugs()
        @playa.moves += 1
      else
        p 'You just walked into a wall dumb ass.'
        move_thugs()         
      end

      game_status()
      print_floorplan()
    end

    def valid_cardinal_direction?(direction)
      /^[N|S|E|W]$/i =~ direction
    end

    def move_thugs
      @thugs.each do |thug|
        move_thug(thug)
      end
    end 

    # recursive, only move one room at a time if the move is valid
    def move_thug(thug)
      next_direction = @directions[rand(@directions.size - 1)]
      
      x, y = *@house.next_room_coords(next_direction, thug.location)
 
      if @house.valid_room?(x, y)
        @house.move_actor(thug.location, [x, y], thug)
        thug.location = [x, y]
      else
        move_thug(thug)
      end
    end

    # check if you encountered the thug or found the stash
    def game_status
      if ass_smoked?
        p "You got your ass smoked."
        end_game()
      end 
      if stash_found?
        puts "You found the stash #{@stash}.\nNow get the hell outta there before your ass gets smoked."      
        @scoreboard.update(@playa)
        end_game()
      end       
    end 

    def stash_found?
      @stash_location[0] == @playa.location[0] and @stash_location[1] == @playa.location[1]
    end 

    def ass_smoked?
      smoked = false
      @thugs.each do |thug|
        return true if thug.location[0] == @playa.location[0] and thug.location[1] == @playa.location[1]
      end
      smoked
    end 

    def print_floorplan
      print @house.floor_plan()
    end

    def end_game
      print_floorplan()
      @scoreboard.print
      Process.exit(1)
    end   
  end
end

s = StashHouse::Engine.new(16)
s.start
