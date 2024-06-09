class HttpStatus
  STATUS_CODES = {
    200 => 'OK',
    201 => 'Created',
    404 => 'Not Found',
    405 => 'Method Not Allowed',
    500 => 'Internal Server Error'
  }.freeze

  def self.message_for_code(code)
    STATUS_CODES[code] || 'Unknown Status'
  end
end
