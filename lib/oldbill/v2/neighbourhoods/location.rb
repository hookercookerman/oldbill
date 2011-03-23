module OldBill
  module V2
    module Neighbourhoods
      class Location < Hashie::Dash
            
        property :name	#Name if available
        property :longitude	#Location longitude
        property :latitude	#Location longitude
        property :postcode	#Postcode
        property :address	#Location address
        property :telephone	#Location latitude
        property :type	#Type of location, e.g. "station" (police station)
        property :description	#Description
        property :session
      
      end
    end
  end
end