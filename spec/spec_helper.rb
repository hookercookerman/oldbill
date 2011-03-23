require "bundler"
Bundler.setup

# get the calculated gem and bundle in the test group
require "oldbill"
Bundler.require(:test)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  config.before(:suite) do
    raise Exception, "You need to set you old bill mate" unless ENV["OLD_BILL_USERNAME"] && ENV["OLD_BILL_PASSWORD"]  
  end
  
   config.before(:each) do
   end
   
  config.mock_with :rspec
end