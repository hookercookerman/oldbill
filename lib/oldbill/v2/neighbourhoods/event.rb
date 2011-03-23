module OldBill
  module V2
    module Neighbourhoods
      class Event < Hashie::Dash
              
        property :description	#Description of the event
        property :title	#Title of the event
        property :address	#Address of the event
        property :type	#Type of event
        property :contact_details 
        property :start_date
        property :session
        
        # email
        # telephone
        def contact_details_parsed(value)
          unless value.nil?
            Hashie::Mash.new(value)
          end
        end
        
        def start_date_parsed(value)
          unless value.nil?
            Date.parse(value)
          end
        end
        
        # == yak!!!!! refactor me please
        def []=(property, value)
          case property 
            when "contact_details"
            super(property.to_s, contact_details_parsed(value))
            when "start_date"
            super(property.to_s, start_date_parsed(value))
          else
            super
          end
        end
        
      end
    end
  end
end