require_relative '../http_handler'
require_relative '../http_response'

class RootResource < HttpHandler
  def call(_request)
    body = ''
    headers = {
      'Content-Type' => 'text/plain',
      'Content-Length' => body.bytesize.to_i
    }
    HttpResponse.new(200, headers, body)
  end
end
