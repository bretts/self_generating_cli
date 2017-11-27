require_relative 'self_generating_cli_module'
Dir.glob(File.dirname(File.absolute_path(__FILE__)) + "/**/*.rb") {|file| require file unless file == __FILE__ }