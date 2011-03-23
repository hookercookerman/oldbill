module OldBill
  module V2
    module Crimes
      class Location < Hashie::Dash
        
      
        property :name	#Name if available
        property :longitude	#Location longitude
        property :latitude	#Location latitude
        property :street	#Location latitude
        
        # id  Unique identifier for the street
        # name  Name of the location.
        # This is only an approximation of where the crime happened
        def street_parsed(value)
          unless value.nil?
            Hashie::Mash.new(value)
          end
        end
        

        def []=(property, value)
          case property 
            when "street"
            super(property.to_s, street_parsed(value))
          else
            super
          end
        end
      
      end
    end
  end
end