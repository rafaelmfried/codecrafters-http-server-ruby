require_relative '../http_handler'
require_relative '../http_response'
require_relative '../logger'

class FileResource < HttpHandler
  def call(request)
    dir_flag = false

    directory = ''
    
    ARGV.each do |arg|
      if dir_flag
        dir_flag = false
        directory = arg
      end
      dir_flag = true if arg == '--directory'
    end

    logger = Logger.new
    logger.log("FileResource called with path: #{request.path}")
    
    file_name = request.path.split('/files/').last || ''
    logger.log("Extracted string: #{file_name}")
    full_path = "#{directory}/#{file_name}"
    file = File.exist?(full_path) ? File.open(full_path, 'r') : nil
    logger.log("File exist?: #{file}")
    file_content = file.read
    logger.log("File content: #{file_content}")
    body = file ? file_content : ''
    
    headers = {
      'Content-Type' => 'application/octet-stream',
      'Content-Length' => file ? file.size : 0
    }

    response = HttpResponse.new(200, headers, body)
    logger.log("Response generated with body: #{body}")

    response
  end
end
