module StashHouse
  class ScoreBoard
    def initialize
      @scoreboard = load_from_file()
    end

    def update(playa)
      @scoreboard[playa.name] = playa.moves
      write_to_file()
    end

    def print
      puts "\nScoreboard"
      puts '--------------'
      puts "Playa \t Moves"
      puts '--------------'
      @scoreboard.sort_by { |name, score| score }.each do |name, score|
        puts "#{name} \t #{score}"
      end
    end

    def to_s
      "#@scoreboard"
    end

    private

    def load_from_file
      @scoreboard_file = File.open('stashhouse/scoreboard.txt', 'r+')
      scoreboard = {}      
      @scoreboard_file.each_line do |line|
        l = line.strip #remove line breaks
        scoreboard[l.split(',')[0]] = l.split(',')[1].to_i
      end
      scoreboard
    end

    def write_to_file
      @scoreboard_file.truncate(0)
      @scoreboard.each do |key, value|
        @scoreboard_file.write("#{key},#{value}\n")
      end
    end 
  end
end