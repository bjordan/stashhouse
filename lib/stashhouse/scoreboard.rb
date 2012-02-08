module StashHouse
	class ScoreBoard
		def initialize
			@scoreboard_file = File.open(File.expand_path(File.dirname(__FILE__) + '/scoreboard.txt'), 'r+')
			@scoreboard = {}
			load_from_file()
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
			@scoreboard.each do |name, score|
				puts "#{name} \t #{score}"
			end
		end

		def to_s
			"#@scoreboard"
		end

		private

		def load_from_file
			@scoreboard_file.each_line do |line|
				l = line.strip #remove line breaks
			  @scoreboard[l.split(',')[0]] = l.split(',')[1]
			end
		end

		def write_to_file
			@scoreboard_file.truncate(0)
			@scoreboard.each do |key, value|
				@scoreboard_file.write("#{key},#{value}\n")
			end
		end	
	end
end