require_relative 'logger'

class Router
  def initialize
    @routes = {}
    @default_handler = ->(request) { HttpResponse.new(404, {'Content-Type' => 'text/plain'}, 'Not Found') }
    @logger = Logger.new
  end

  def add_route(pattern, handler)
    @routes[pattern] = handler
    @logger.log("Added route: #{pattern}")
  end

  def set_default_handler(handler)
    @default_handler = handler
  end

  def route(request)
    @logger.log("Routing request for path: #{request.path}")
    handler = @routes.find { |pattern, _| request.path.match(pattern) }&.last || @default_handler
    @logger.log("Handler found: #{handler.class.name}")
    handler.call(request)
  rescue => e
    @logger.log("Error handling request: #{e.message}")
    HttpResponse.new(404, {'Content-Type' => 'text/plain'}, 'Not Found')
  end
end
