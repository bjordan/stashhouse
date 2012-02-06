module StashHouse
	class Stash
		attr_accessor :contents

		def initialize(contents)
			@contents = contents
		end

		def to_s
			"#@contents"
		end
	end
end