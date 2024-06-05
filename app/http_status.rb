class HttpStatus
  STATUS_CODES = {
    200 => 'OK',
    404 => 'Not Found',
    500 => 'Internal Server Error'
  }.freeze

  def self.message_for_code(code)
    STATUS_CODES[code] || 'Unknown Status'
  end
end
