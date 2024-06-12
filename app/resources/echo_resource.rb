require 'zlib'
require 'stringio'
require_relative '../http_handler'
require_relative '../http_response'
require_relative '../logger'

class EchoResource < HttpHandler
  def call(request)
    logger = Logger.new
    logger.log("EchoResource called with path: #{request.path}")

    str = request.path.split('/echo/').last || ''
    logger.log("Extracted string: #{str}")

    accept_encoding = request.headers['Accept-Encoding'] || request.headers['accept-encoding']
    if accept_encoding&.include?('gzip')
      logger.log("Client accepts gzip encoding")
      body = gzip_compress(str)
      headers = {
        'Content-Encoding' => 'gzip',
        'Content-Type' => 'text/plain',
        'Content-Length' => body.bytesize.to_s
      }
    else
      logger.log("Client does not accept gzip encoding or invalid encoding provided")
      body = str
      headers = {
        'Content-Type' => 'text/plain',
        'Content-Length' => body.bytesize.to_s
      }
    end

    response = HttpResponse.new(200, headers, body)
    logger.log("Response generated with body: #{body}")

    response
  end

  private

  def gzip_compress(str)
    buffer = StringIO.new
    w_gz = Zlib::GzipWriter.new(buffer)
    w_gz.write(str)
    w_gz.close
    buffer.string
  end
end
