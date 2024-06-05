class HttpHeaders
  def self.parse(client)
    headers = {}
    while (line = client.gets) && (line != "\r\n")
      header, value = line.split(': ', 2)
      headers[header] = value&.strip
    end
    headers
  end
end
