module OldBill
  module V2
    module Neighbourhoods
      class Locator < Hashie::Dash
                
        # == Propertys
        property :force	#Unique force identifier
        property :neighbourhood	#Force specific team identifier
        property :session
        
        # @return [Arrray<OldBill::V2::CrimeByMonth>]
        def crimes_by_month
          @crimes_by_month ||= session.crimes_by_month(self.force, self.neighbourhood)
        end
        
        # @return [O]ldBill::V2::Neighbourhood]
        def full_neighbourhood
          @full_neighbourhood ||= session.neighbourhood(self.force, self.neighbourhood)
        end
        
        # @return [Arrray<OldBill::V2::Neighbourhoods::Events>]
        def events
          @events ||= session.events(self.force, self.neighbourhood)
        end
        
        # @return [Arrray<OldBill::V2::Neighbourhoods::PoliceOfficers>]
        def police_officers
          @police_officers ||= session.police_officers(self.force, self.neighbourhood)
        end
      
      end
    end
  end
end