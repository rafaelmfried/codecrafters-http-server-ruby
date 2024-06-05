class Logger
  def log(message)
    timestamp = Time.now.strftime "%Y-%m-%d %H:%M%S"
    puts "[#{timestamp}] #{message}"
  end

  def error(message)
    log("ERROR - #{message}")
  end
end