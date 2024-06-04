require "socket"

# You can use print statements as follows for debugging, they'll be visible when running tests.
print("Logs from your program will appear here!")

# Uncomment this to pass the first stage
#
server = TCPServer.new("localhost", 4221)
client_socket, client_address = server.accept
request = client_socket.gets
_, path, _ = request.chomp.split

case path
  when "/"
    client_socket.puts "HTTP/1.1 200 OK\r\n\r\n"
  else
    client_socket.puts "HTTP/1.1 404 Not Found\r\n\r\n"
end
