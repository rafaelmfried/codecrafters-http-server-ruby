class HttpRequest
  attr_accessor :method, :path, :headers, :body

  def initialize(method, path, headers, body)
    @method = method
    @path = path
    @headers = headers
    @body = body
  end
end
