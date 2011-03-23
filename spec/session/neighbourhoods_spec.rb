# encoding: utf-8
require File.expand_path("../../spec_helper", __FILE__)
require File.expand_path('../../vcr_enabled', __FILE__)

describe "crime api" do
  use_vcr_cassette 'share', :record => :new_episodes
  
  context "#neighbourhoods" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call neighbourhoods" do
      lambda{@session.neighbourhoods("leicestershire")}.should_not raise_error
    end
    
    it "should give me some cool neighbourhoods" do
      neighbourhood = @session.neighbourhoods("leicestershire")[0]
      neighbourhood.name.should_not be_nil
      neighbourhood.id.should_not be_nil
      neighbourhood.should_not be_fully_loaded
    end
    
    it "should be able to come fully_loaded" do
      neighbourhood = @session.neighbourhoods("leicestershire")[0]
      neighbourhood.fully_loaded!
      neighbourhood.centre.latitude.should_not be_nil
    end
    
    it "should raise 404 when random force" do
      lambda{@session.neighbourhoods("random")}.should raise_error(OldBill::NotFoundError)
    end
  end
  
  context "#neighbourhood" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call neighbourhoods" do
      lambda{@session.neighbourhood("leicestershire", "C01")}.should_not raise_error
    end
    
    it "should give me a cool neighbourhood" do
      neighbourhood = @session.neighbourhoods("leicestershire")[0]
      neighbourhood.fully_loaded!
      neighbourhood.centre.latitude.should_not be_nil
      neighbourhood.contact_details.should_not be_empty
      neighbourhood.contact_details.email.should_not be_nil
    end
    
    it "should be cool to get some crimes" do
      neighbourhood = @session.neighbourhoods("leicestershire")[0]
      neighbourhood.street_level_crimes.should_not be_empty
      neighbourhood.street_level_crimes[0].category.should_not be_empty
    end
  end
  
  context "#events" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call events" do
      lambda{@session.events("leicestershire", "C01")}.should_not raise_error
    end
    
    it "should give me a cool event" do
      event = @session.events("leicestershire", "C01")[0]
      event.start_date.should_not be_nil
      event.start_date.should be_a(Date)
      event.description.should_not be_nil
    end
  end
  
  context "#police_officers" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call events" do
      lambda{@session.police_officers("leicestershire", "C01")}.should_not raise_error
    end
    
    it "should give me a cool event" do
      police_officer = @session.police_officers("leicestershire", "C01")[0]
      police_officer.bio.should_not be_nil
      police_officer.name.should.should_not be_nil
      police_officer.rank.should.should_not be_nil
    end
  end
  
  context "#locate" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call events" do
      lambda{@session.locate(52.6397278, -1.1322921)}.should_not raise_error
    end
    
    it "should bring back nil when no location found" do
      @session.locate(33, -1).should be_nil
    end
    
    it "should give me a cool locator" do
      locator = @session.locate(52.6397278, -1.1322921)
      locator.neighbourhood.should_not be_nil
      locator.force.should_not be_nil
    end
    
    it "should be cool to get crimes_by_month" do
      locator = @session.locate(52.6397278, -1.1322921)
      locator.crimes_by_month.should_not be_empty
      locator.crimes_by_month[0].month.should_not be_nil
    end
    
    
    it "should be cool to get police_officers" do
      locator = @session.locate(52.6397278, -1.1322921)
      locator.police_officers.should_not be_empty
      locator.police_officers[0].rank.should_not be_nil
    end
    
    it "should be cool to get events" do
      locator = @session.locate(52.6397278, -1.1322921)
      locator.events.should_not be_empty
      locator.events[0].description.should_not be_nil
    end
  end
end