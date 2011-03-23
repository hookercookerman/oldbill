module OldBill
  class Service
    include HTTParty
    format :json
    headers = {'Accept' => 'application/json'}
    
    # api not used is in server 
    def initialize(server, api_version, username, password, logging = false)
      self.class.base_uri server
      self.class.send(:debug_output) if logging
      self.class.basic_auth username, password
    end
    
    def get(path, params = {})
      perform_request(:get, path, params)
    end
      
    private
    def perform_request(type, path, params)
      response = self.class.send(type, path, :query => params)
      check_response(response)
      response
    rescue Errno::ECONNREFUSED, SocketError
      raise OldBill::ServerNotFound, "Police API Server could not be found"
    end
    
    # checking the status code of the response; if we are not authenticated
    # then authenticate the session
    # @raise [OldBill:BadRequestError] if the status code is 400
    # @raise [OldBill:UnauthorizedRequestError] if a we get a 401
    def check_response(response)
      case response.code
        when 400 then raise OldBill::BadRequestError.new "Not enough parameters to produce a valid response."
        when 401 then raise OldBill::UnauthorizedRequestError.new "The username password could not be recognised and the request is not authorized."
        when 403 then raise OldBill::ForbiddenError.new "The requested method is not available you do not have access"
        when 404 then raise OldBill::NotFoundError.new "A method was requested that is not available in the API version specified"
        when 405 then raise OldBill::MethodNotAllowedError.new "The HTTP request that was made requested an API method that can not process the HTTP method used."
        when 500 then raise OldBill::InternalServerError.new "Internal Server Error"
      end
    end
  
  end
end