module OldBill
  class Session
            
    # accessors
    attr_accessor :cache, :caching, :logging, :server, :expires_in, :api_version
    
    include OldBill::Api::Crime
    include OldBill::Api::Neighbourhood
    
    # creating a session one must supply the api_key as this is always required basically
    # @param [Hash] options
    # @return [OldBill::Session]
    def self.create(options = {})
      username = options.delete(:username)
      password = options.delete(:password)
      raise ArgumentError.new("You need a username password") unless username && password
      new(username, password, options)
    end
    
    # @param [String] api_key
    # @param [Hash] options
    # default options
    #   caching => true
    #   expires_in => 60*60*24
    #   cache => Moneta::Memory.new
    #   server => "policeapi2.rkh.co.uk/api/" server has api version hmm should be param!
    #   api_version => 2
    #   logging => true
    def initialize(username, password, options)
      @username = username
      @password = password
      if @caching = options[:caching].nil? ? true : options.delete(:caching)
        @expires_in = options.delete(:expires_in) || 60*60*24
        @cache = options.delete(:cache) || Moneta::Memory.new 
      end
      @server = options.delete(:server) || "policeapi2.rkh.co.uk/api"
      @api_version = options.delete(:api_version) || 2
      @logging = options[:logging].nil? ? false : options.delete(:logging)
    end
    
    def api_call(method, path, params ={}, &proc)
      if cache = caching? && (@cache[cache_key(path, params)])
        return cache
      else
        result = service.send(method, path, params)
        result = yield result if block_given?
        store_call(result, path, params || {}) if caching?
        result
      end
    end
    
    def service 
      @service ||= OldBill::Service.new(@server, @api_version, @username, @password, @logging)
    end
    
    def caching?
      @caching
    end
      
    protected
    # @param [String] path
    # @param [Hash] params
    # @return [String] the cache key from the path and the params
    def cache_key(path, params = {})
      parts = []
      parts << path
      parts << params.to_a
      parts.join("/")
    end
    
    # @param [Object] result
    # @param [String] path
    # @param [Hash] params
    def store_call(result, path, params)
      key = cache_key(path, params ||{})
      @cache.store(key, result, :expires_in => @expires_in)
    end
    
    def merge_session!(hash)
      hash.merge({:session => self})
    end
            
  end
end