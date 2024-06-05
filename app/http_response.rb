require_relative 'http_status'

class HttpResponse
  attr_accessor :status_code, :headers, :body

  def initialize(status_code, headers = {}, body = '')
    @status_code = status_code
    @headers = headers
    @body = body
  end

  def to_s
    status_message = HttpStatus.message_for_code(@status_code)
    response = "HTTP/1.1 #{@status_code} #{status_message}\r\n"
    @headers.each do |key, value|
      response += "#{key}: #{value}\r\n"
    end
    response += "\r\n#{@body}"
    response
  end
end
