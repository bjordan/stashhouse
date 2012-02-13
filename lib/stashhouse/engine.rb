require 'yaml'

%w[house thug stash playa scoreboard].each { |i| require_relative i }

module StashHouse
  class Engine   
    def initialize     
      @num_rows , @num_cols, @num_thugs = load_config()
      
      @scoreboard = ScoreBoard.new
      @house = House.new(@num_rows, @num_cols)

      @stash = Stash.new(["100 Red Tops", "200 Yellow Tops"])
      @thugs = []
      @num_thugs.times { @thugs << Thug.create() }
    end

    def init_actor_locations
      @playa.location = [@num_rows-1, rand(@num_cols)]
      @house.rooms[@playa.location[0]][@playa.location[1]].contents.push(@playa)

      @stash.location = [0, rand(@num_cols)]
      @house.rooms[@stash.location[0]][@stash.location[1]].contents.push(@stash)

      @thugs.each do |thug|
        thug.location = [(@num_rows / 2).ceil, rand(@num_cols)]
        @house.rooms[thug.location[0]][thug.location[1]].contents.push(thug)
      end
    end

    def start
      create_playa()

      instructions = "#{@playa.name}(P), find the stash(S) before the thugs(T) smoke your ass.\n"
      instructions += "Enter direction, N(North), S(South), E(East) or W(West) (ENTER to exit)\n"

      init_actor_locations()  
      print instructions
      print_floorplan()

      while true
        print '> '
        input = STDIN.gets.chomp()

        if input.empty?
          Process.exit(1)
        elsif valid_cardinal_direction?(input) 
          move(input.upcase)
        else  
          print instructions
        end
      end
    end

    def move(direction)
      # convert direction to next room coordinates
      x, y = @house.next_room_coords(direction, @playa.location)

      # check if move is valid (not off the map)
      if @house.valid_room?(x, y)
        @house.move_actor(@playa, [x, y])
        @playa.location = [x, y]
        game_status()
        @playa.moves += 1
      else
        puts 'You just walked into a wall dumb ass.'
      end

      move_thugs()
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
      directions = ['N', 'S', 'E', 'W']
      next_direction = directions[rand(directions.size)]
      
      x, y = *@house.next_room_coords(next_direction, thug.location)
 
      if @house.valid_room?(x, y)
        @house.move_actor(thug, [x, y])
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
        puts "You found the stash #{@stash.contents}.\nNow get the hell outta there before your ass gets smoked."      
        @scoreboard.update(@playa)
        end_game()
      end       
    end 

    def stash_found?
      @house.in_same_room?(@stash, @playa)
    end 

    def ass_smoked?
      @thugs.each do |thug|
        return true if @house.in_same_room?(thug, @playa)
      end
      false
    end 

    def print_floorplan
      print @house.floor_plan()
    end

    def create_playa
      @playa = nil
      while @playa.nil?
        print 'What\'s yo name playa? '
        playa_name = STDIN.gets.chomp().capitalize
        @playa = Playa.new(playa_name) unless playa_name.empty?
      end   
    end

    def load_config
      config = YAML.load_file(File.expand_path('stashhouse/config.yml'))
      [config['house_dimensions'][:rows], config['house_dimensions'][:cols], config[:num_thugs]]
    end

    def end_game
      print_floorplan()
      @scoreboard.print
      exit_program()
    end
    
    def exit_program 
      Process.exit(1)
    end
  end
end