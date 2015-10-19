require 'socket'
require 'timeout'
require_relative 'protocol.rb'

class Scanner
	
	def initialize node_name
		@node_name = node_name
	end

	def scan
		nodes = []

		(0 .. 255).each do |ip_lsb|
			ip = LOCAL_IP + ip_lsb.to_s
			# add try-catch
			socket = nil
			begin
				Timeout.timeout(2) do
					socket = TCPSocket.new ip, PORT
				end
				to_send = send_ping_operation @node_name
				socket.puts to_send

				message = ""
				while line = socket.gets
					message += line
				end
				nodes.push get_ping_operation message
				puts "Scanned succesfully: " + (get_ping_operation message) 
			rescue Timeout::Error
				puts "Connection timedout on: " + ip 
			rescue Errno::ENETUNREACH
				puts "You've got an internet problem connecting to: " + ip
			rescue Errno::ECONNREFUSED
				puts "Refused connection on: " + ip
			rescue Errno::EHOSTUNREACH
				puts "DNS wtf?: " + ip 
			ensure
					socket.close if !socket.nil?
			end
		end

		return nodes	
	end


end



