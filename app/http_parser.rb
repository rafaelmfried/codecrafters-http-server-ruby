require_relative 'http_headers'

class HttpParser
  def self.parse_request(request_line, headers, body)
    method, path, _ = request_line.split(' ')
    headers_hash = HttpHeaders.parse(headers)
    HttpRequest.new(method, path, headers_hash, body)
  end
end
