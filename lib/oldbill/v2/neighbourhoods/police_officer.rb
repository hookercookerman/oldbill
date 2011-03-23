module OldBill
  module V2
    module Neighbourhoods
      class PoliceOfficer < Hashie::Dash
              
        property :bio	#Team member biography (if available)
        property :name	#Name of the person
        property :rank	#Force rank
        property :contact_details #	Unique force identifier
        property :session
        
        # email
        # telephone
        def contact_details_parsed(value)
          unless value.nil?
            Hashie::Mash.new(value)
          end
        end
        
        # == yak!!!!! refactor me please
        def []=(property, value)
          case property 
            when "contact_details"
            super(property.to_s, contact_details_parsed(value))
          else
            super
          end
        end
      
      end
    end
  end
end