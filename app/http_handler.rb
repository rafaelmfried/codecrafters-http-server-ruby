class HttpHandler
  def call(request)
    raise NotImplementedError, 'Subclasses must implement the call method'
  end
end
