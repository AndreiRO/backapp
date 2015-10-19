require 'yaml'

		
PORT = 1918
IP = '0.0.0.0'
LOCAL_IP = '192.168.0.'

def send_ping_operation node_name
	message = {
					:operation => :ping,
					:name => node_name
			  }

	message = YAML.dump message
	message = message.lines.count.to_s + "\n" + message

	return message
end

def send_ping_result node_name
	message = {
				:operation => :ping,
				:name => node_name
			}

	return YAML.dump message
end

def get_ping_operation message
	result = YAML.load message
	
	return result[:name]
end
