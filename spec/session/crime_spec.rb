# encoding: utf-8
require File.expand_path("../../spec_helper", __FILE__)
require File.expand_path('../../vcr_enabled', __FILE__)

describe "crime api" do
  use_vcr_cassette 'share', :record => :new_episodes
  context "#forces" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
  
    it "should be cool in getting some forces" do
      lambda{@session.forces}.should_not raise_error
    end
  
    it "should include bedfordshire as one of its forces do" do
      forces = @session.forces
      forces.detect{|force| force.id == "bedfordshire"}.should_not be_nil
    end
  
    it "should have each force with a name and an id" do
      @session.forces.each do |force|
        force.should respond_to(:id)
        force.should respond_to(:name)
      end
    end
  end
  
  
  context "#force" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
  
    it "should be cool a call force" do
      lambda{@session.force("bedfordshire")}.should_not raise_error
    end
  
    it "should be cool to get bedfordshire" do
     @session.force("bedfordshire").should_not be_nil
    end
    
    it "should have some engagement-methods" do
      force = @session.force("bedfordshire")
      force.engagement_methods.should_not be_empty
    end
    
    it "should have engagement_methods as a hashie mash" do
      force = @session.force("bedfordshire")
      force.engagement_methods[0].class.should eq(Hashie::Mash)
    end
    
    it "should have engagement_methods with title url description" do
      force = @session.force("bedfordshire")
      force.engagement_methods.each do |engagement_method|
        engagement_method.should respond_to(:title)
        engagement_method.should respond_to(:url)
        engagement_method.should respond_to(:description)
      end
    end
  end
  
  context "#crimes_by_month" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should cool to call crimes_by_month" do
      lambda{@session.crimes_by_month("leicestershire", "C01")}.should_not raise_error
    end
    
    it "should bring back empty array when no data" do
      @session.crimes_by_month("bedfordshire", "C01").should be_empty
    end
    
    it "should create a nice looking crime by month object" do
      crime_by_month = @session.crimes_by_month("leicestershire", "C01")[0]
      crime_by_month.month.should_not be_empty
      crime_by_month.burglary.should_not be_empty
    end
  end

  context "#street_level_crimes" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should cool to call street_level_crimes" do
      lambda{@session.street_level_crimes(51, 48)}.should_not raise_error
    end
    
    it "should bring back empty array when no data" do
      @session.street_level_crimes(0, 0).should be_empty
    end
    
    it "should create a nice looking street_level_crimes object" do
      street_crimes = @session.street_level_crimes(52.6397278, -1.1322921)
      street_crime = street_crimes[0]
      street_crime.category.should_not be_nil
      street_crime.month.should_not be_nil
      street_crime.location.should_not be_nil
      street_crime.location.street.name.should_not be_nil
    end
  end
  
  context "#crime_categories" do
    before(:each) do
      @session = OldBill::Session.create(:username => ENV["OLD_BILL_USERNAME"], :password => ENV["OLD_BILL_PASSWORD"])
    end
    
    it "should be cool to call crime_categories" do
      lambda{@session.crime_categories}.should_not raise_error
    end
    
    it "should include bulgary as one of its categories" do
      categories = @session.crime_categories
      categories.detect{|category| category.url == "burglary"}.should_not be_nil
    end
  end
  
end