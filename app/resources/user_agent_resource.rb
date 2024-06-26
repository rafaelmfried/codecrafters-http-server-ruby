require_relative '../http_handler'
require_relative '../http_response'
require_relative '../logger'

class UserAgentResource < HttpHandler
  def call(request)
    logger = Logger.new
    logger.log("UserAgent called with path: #{request.path}")

    str = request.headers['User-Agent']
    logger.log("Extracted string: #{str}")

    body = str
    headers = {
      'Content-Type' => 'text/plain',
      'Content-Length' => body.bytesize.to_s
    }

    response = HttpResponse.new(200, headers, body)
    logger.log("Response generated with body: #{body}")

    response
  end
end
