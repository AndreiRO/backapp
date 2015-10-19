require '../src/communication/scanner.rb'
require '../src/communication/server.rb'
require 'test/unit'
require 'socket'



class TestScanner < Test::Unit::TestCase

	def test_one_listening_server
		server = Server.new "server"
		server.start

		scanner = Scanner.new "scanner"
		nodes = scanner.scan
		
		assert_not_equal [], nodes
		assert_equal 1, nodes.length
		assert_equal "server", nodes[0]

		server.terminate
	end

end

