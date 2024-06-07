require 'socket'
require_relative 'http_parser'
require_relative 'http_request'
require_relative 'http_response'
require_relative 'http_status'
require_relative 'router'
require_relative 'logger'

class HttpServer
  def initialize(port)
    @server = TCPServer.new(port)
    @router = Router.new
    @logger = Logger.new
    configure_routes
  end

  def configure_routes
    require_relative 'resources/echo_resource'
    require_relative 'resources/root_resource'
    require_relative 'resources/user_agent_resource'
    require_relative 'resources/file_resource'

    @router.add_route(/^\/$/, RootResource.new)
    @router.add_route(/^\/echo/, EchoResource.new)
    @router.add_route(/^\/user-agent/, UserAgentResource.new)
    @router.add_route(/^\/files/, FileResource.new)
    @router.set_default_handler(->(request) { HttpResponse.new(404, {'Content-Type' => 'text/plain'}, 'Not Found') })
  end

  def start
    loop do
      client = @server.accept
      request_line = client.gets
      next unless request_line

      method, path, _ = request_line.split(' ')
      @logger.log("Received request: #{method} #{path}")

      headers = HttpHeaders.parse(client)
      @logger.log("Parsed headers: #{headers}")

      body = client.read(headers['Content-Length'].to_i) if headers['Content-Length']
      @logger.log("Parsed body: #{body}")

      request = HttpRequest.new(method, path, headers, body)
      response = @router.route(request)
      client.puts response.to_s

      @logger.log("Response: #{response.status_code} #{response.body}")
    rescue => e
      @logger.error("Error processing request: #{e.message}")
      client.puts HttpResponse.new(500, {'Content-Type' => 'text/plain'}, 'Internal Server Error').to_s
    ensure
      client.close
    end
  end
end
