require_relative "http_server"

begin
  server = HttpServer.new(4221)
  server.start
rescue => e
  Logger.new.error(e.message)
end

