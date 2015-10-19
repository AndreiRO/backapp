require_relative "protocol.rb"
require "socket"
require "yaml"


class Server

	def initialize node_name
		@node_name = node_name
	end

	def start
		@thread = Thread.new { 
			server = TCPServer.new IP, PORT 
			loop do
				client = server.accept
				th = Thread.new { self.new_connection client }
				th.run
			end
		}
		@thread.run
	end

	def new_connection client
		message = ""
		nr_lines = client.gets
		nr_lines = nr_lines.to_i
		counter = 0	

		while counter < nr_lines
			message += client.gets
			counter += 1
		end
		result = YAML.load message
		
		case result[:operation]
		when :ping
			message = send_ping_result @node_name
			client.puts message
			client.close
		end

	end

	def terminate
		Thread.kill(@thread)
	end

end

