require File.dirname(__FILE__) + '/../spec_helper'

describe "Session" do
  describe "when creating, .create" do
    it "should be cool when supplying an api key" do
      OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should have the defaults" do
      session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
      session.server.should == "policeapi2.rkh.co.uk/api"
      session.api_version.should == 2
      session.logging.should be_false
      session.caching.should be_true
    end
    
    it "should allow defaults to be changed when creating" do
      session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"], :api_version => 3, :logging => false, :server => "beans")
      session.server.should == "beans"
      session.logging.should be_false
      session.api_version.should == 3
    end
    
    it "should raise Argument error if no api key is supplied; with message 'need API to save the planet!'" do
      lambda{OldBill::Session.create}.should raise_error(ArgumentError)
    end
  end
end