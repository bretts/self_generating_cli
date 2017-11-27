require_relative 'test_helper'
require 'stringio'

class CommandExecutorTest < MiniTest::Test

	def test_execute_command
		stringio = StringIO.new
		$stdout  = stringio

		command_exec  = CommandExecutor.new
		cmd           = "#{command_exec.execute('?')}"
		 `"#{cmd}"`
		$stdout       = STDOUT

		assert_match(/commands related to movement/, stringio.string)
	end
end