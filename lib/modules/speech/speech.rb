class Speech < SelfGeneratingCliModule
	def initialize
		super()
		@description = 'commands related to speech'
	end

	# Says something
	#
	# @param what_to_say [Array<String>] What you wanted to say
	#
	# @cli_description "Says something"
	# @cli_example "say-something hello to you"
	def say_something(*what_to_say)
		puts "said: #{what_to_say.join(' ')}!"
	end


	# Sings sometihng
	#
	# @param what_to_sing [Array<String>] What you wanted to sing
	#
	# @cli_description "Sings something"
	# @cli_example "sing-something what's going on?"
	def sing_something(*what_to_sing)
		puts "sang: #{what_to_sing.join(' ')}"
	end
end