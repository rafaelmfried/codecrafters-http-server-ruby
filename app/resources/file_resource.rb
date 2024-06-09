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

    begin
      case request.method
      when 'GET'
        logger.log("Method: #{request.method}")
        if File.exist?(full_path)
          file_content = File.read(full_path)
          logger.log("File content: #{file_content}")
          headers = {
            'Content-Type' => 'application/octet-stream',
            'Content-Length' => file_content.size
          }
          response = HttpResponse.new(200, headers, file_content)
        else
          logger.log("File not found: #{full_path}")
          response = HttpResponse.new(404)
        end
      when 'POST'
        logger.log("Method: #{request.method}")
        File.write(full_path, request.body)
        response = HttpResponse.new(201)
      else
        logger.log("Method not supported: #{request.method}")
        response = HttpResponse.new(405) # Method Not Allowed
      end
    rescue => e
      logger.log("Error handling request: #{e.message}")
      response = HttpResponse.new(500) # Internal Server Error
    ensure
      logger.log("Response: #{response.status_code} #{response.to_s}")
    end
    
    response
  end
end
