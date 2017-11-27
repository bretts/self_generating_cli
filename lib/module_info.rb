#require 'singleton'
require 'yard'

class ModuleInfo

	# Returns a list of classes that inherit SelfGeneratingCliModule
	def get_loaded_modules
		cli_modules = []

		Dir.glob(File.expand_path('../lib', File.dirname(File.absolute_path(__FILE__))) + '/modules/**/*.rb').each do |file|
			current_file = YARD::Parser::Ruby::RubyParser.parse(File.read(file)).root

			if(current_file.jump(:class).superclass.path[0] == 'SelfGeneratingCliModule')
				cli_modules << Object.const_get(current_file.jump(:class).class_name.path[0])
			end
		end

		return cli_modules
	end

	# Uses yard to parse comments and return information about the methods
	#
	# @param class_type [Class] the class type to parse for yard comments
	# @return [Hash] containing all the method names, descriptions, and exampes for the given class
	#
	# @example
	# 	get_method_info(Speech)
	def get_method_info(class_type)
		cli_modules = get_loaded_modules

		klass       = cli_modules.select { |klass| klass == class_type }[0]
		method_info = {}
		if(klass.nil?)
			raise StandardError, "Tried to get method info for #{class_type}, but it did not exist"
		else
			Dir.glob(File.expand_path('../lib', File.dirname(File.absolute_path(__FILE__))) + '/modules/**/*.rb').each do |file|
				current_file = YARD::Parser::Ruby::RubyParser.parse(File.read(file)).root

				if(current_file.jump(:class).class_name.path[0] == klass.to_s)
					current_file.traverse do |obj|
						if(obj.class == YARD::Parser::Ruby::MethodDefinitionNode)
							if(docstring = obj.docstring)
								doc_elements = docstring.split("\n")
								if(["@cli_description", "@cli_example"].all? { |e| doc_elements.grep(/#{e}/)[0] })
									meth_ref = obj.method_name[0].gsub('_', '-')
									method_info[meth_ref] ||= {}
									method_info[meth_ref][:cli_description] = doc_elements.select { |e| e.include?("@cli_description") }[0].split("@cli_description")[1].strip.gsub('"', '')
									method_info[meth_ref][:cli_example] = doc_elements.select { |e| e.include?("@cli_example") }[0].split("@cli_example")[1].strip.gsub('"', '')
								end
							end
						end
					end
					break
				end
			end

			return method_info
		end
	end

	# Converts a Class name into a CLI module name
	#
	# @param class_type [Class] the Class type
	# @return [String] representing the CLI module name
	#
	# @example
	# 	get_module_name(Speech)
	def get_module_name(class_type)
		class_name    = class_type.name
		result        = []
		found_capital = false

		class_name.chars.each do |char|
			if(char.ord <= 90)
				if(found_capital == true)
					result << '-'
				end
				found_capital = true
			end

			result << char.downcase
		end

		return result.join('')
	end
end