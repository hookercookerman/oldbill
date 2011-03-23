module OldBill
  
  # Raised when OldBill server cannot be found
  class ServerNotFound < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 400
  class BadRequestError < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 401
  class UnauthorizedRequestError < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 403
  class ForbiddenError < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 404
  class NotFoundError < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 405
  class MethodNotAllowedError < StandardError; end
  
  # Raised when OldBill returns the HTTP status code 500
  class InternalServerError < StandardError; end
    
end