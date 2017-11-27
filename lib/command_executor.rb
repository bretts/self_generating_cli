class CommandExecutor
	HELP_COMMANDS = ['help', '?', 'h']

	# Executes commands in modules
	#
	# @param input [String] module-name method-name method-params
    # @return [nil]
    #
    # @example
    # 	execute("speech say-something hi there")
	def execute(input)
		if(HELP_COMMANDS.any? { |command| command == input })
			module_info = ModuleInfo.new
			classes     = module_info.get_loaded_modules

			printf "%-18s %-35s", "Module Name", "Description"
			puts "\n------------------------------"
			classes.each do |klass|
				obj = klass.new

				printf "%-18s %-35s", module_info.get_module_name(klass), obj.description
				puts "\n"
			end
			puts "\n"
		else
			module_info     = ModuleInfo.new
			classes         = module_info.get_loaded_modules
			desired_module  = input.split[0].strip
			found_submodule = false

			classes.each do |klass|
				obj = klass.new
				if(module_info.get_module_name(klass) == desired_module)
					found_submodule     = true
					args                = input.split[1..-1]
					method_name         = args.shift
					method_name         = 'help' if method_name.nil?

					if(HELP_COMMANDS.any? { |command| command == method_name })
						method_info = module_info.get_method_info(obj.class)
						printf "%-25s %-35s", "Command Name", "Example"
						puts "\n------------------------------------------------------------"
						method_info.each do |meth_name, meth_info|
							printf "%-25s %-35s", meth_name, meth_info[:cli_example]
							puts "\n"
						end
					else
						begin
							obj.send(method_name.gsub('-', '_'), *args)
						rescue ArgumentError => e
							puts e.message + " - Try typing {#{HELP_COMMANDS.join('|')}} for more information"
						rescue NoMethodError => e
							puts "There is nothing in #{desired_module} that responds to: #{method_name.gsub('-', '_')}. Type #{desired_module} {#{HELP_COMMANDS.join('|')}} for more info"
						rescue StandardError => e
							puts e.message
						end
					end
				end
				break if found_submodule
			end
			puts "\n"
			if(found_submodule == false)
				puts "Your command: '#{desired_module}' was not found. Try typing {#{HELP_COMMANDS.join('|')}} for more info"
			end
		end
	end
end