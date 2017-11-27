require_relative 'test_helper'

class ModuleInfoTest < MiniTest::Test

	def test_get_module_name_with_single_word_class
		module_info = ModuleInfo.new
		result      = module_info.get_module_name(Speech)

		assert_equal('speech', result)
	end

	def test_get_module_name_with_multi_word_class
		skip('needs a class to exist in modules like: StuffHere')
	end

	def test_get_method_info
		module_info = ModuleInfo.new
		result      = module_info.get_method_info(Speech)
		speech      = result["say-something"]

		assert_equal(speech[:cli_description], "Says something")
		assert_equal(speech[:cli_example], "say-something hello to you")
	end
end