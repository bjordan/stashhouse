module StashHouse
	class Playa
		attr_accessor :name, :moves

		def initialize(name)
			@name = name
			@moves = 0
		end

		def to_s
			"#@name #@moves"
		end
	end
end