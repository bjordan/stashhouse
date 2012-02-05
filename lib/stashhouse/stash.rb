module Stashhouse
	class Stash
		attr_accessor :contents

		def initialize(contents)
			@contents = contents
		end
	end
end