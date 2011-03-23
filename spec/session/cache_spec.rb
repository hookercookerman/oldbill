# encoding: utf-8
require File.expand_path("../../spec_helper", __FILE__)
require File.expand_path('../../vcr_enabled', __FILE__)

describe "Session caching on" do
  use_vcr_cassette 'share', :record => :new_episodes
  
  before(:each) do
    @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
    end
    
    it "should create the cache key from the request" do
      @session.forces
      @session.cache.should_not be_empty
      @session.cache.keys.should include("/forces/")  
    end
    
    it "should give exactly the same response as the first request" do
      response1 = @session.forces
      response2 = @session.cache["/forces/"]
      response1.should == response2
      response2.should == @session.forces
    end
  end
end


describe "Session caching off" do
  use_vcr_cassette 'share', :record => :new_episodes
  before(:each) do
    @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"], :caching => false)
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
    end
    
    it "should not create the cache key from the request" do
      @session.forces
      @session.cache.should be_nil
    end
  
  end
end

describe "Session expiration" do
  use_vcr_cassette 'share', :record => :new_episodes
  
  before(:each) do
    @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"], :expires_in => 1)
  end
  
  describe "Cache" do
    before(:each) do
      @service = @session.service
    end
    
    it "should create the cache" do
      @session.forces
      @session.cache.should_not be_empty
    end
    
    it "should expire when the time as gone passed expiration" do
      @session.forces
      @time_now = Time.parse("Feb 24 2100")
      Time.stub!(:now).and_return(@time_now)
      @session.cache["/forces/"].should be_nil
    end
  end
end