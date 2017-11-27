class Movement < SelfGeneratingCliModule
	def initialize
		super()
		@description = 'commands related to movement'
	end

	# Moves forward
	#
	# @param steps [Integer] Number of steps to move foward
	#
	# @cli_description "Moves forward by "
	# @cli_example "move-forward 2"
	def move_forward(steps)
		puts "I take #{steps} steps forward"
	end


	# Moves backwards
	#
	# @param stuff [Integer] Number of steps to move backwards
	#
	# @cli_description "Moves backwards by the specified number of steps"
	# @cli_example "move-backwards 2"
	def move_backwards(steps)
		puts "I take #{steps} steps back"
	end
end