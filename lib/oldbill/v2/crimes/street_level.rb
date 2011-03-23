module OldBill
  module V2
    module Crimes
      class StreetLevel < Hashie::Dash
        
        property :category	#Category of the crime
        property :id	#ID of the crime.
        property :context	#Extra information about the crime (if applicable)
        property :month	#Month of the crime
        property :location	#Month of the crime
        property :session	#Month of the crime
      
        def location_parsed(value)
          unless value.nil?
            Location.new(value)
          end
        end
        
        # == yak!!!!! refactor me please
        def []=(property, value)
          case property 
            when "location"
            super(property.to_s, location_parsed(value))
          else
            super
          end
        end
                
      end
    end
  end
end