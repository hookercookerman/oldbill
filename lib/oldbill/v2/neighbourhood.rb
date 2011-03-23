module OldBill
  module V2
    class Neighbourhood < Hashie::Dash
    
      property :id	 #Police force specific team identifier.
      property :url_force	#URL for the neighbourhood on the Force's website
      property :name #Name of the neighbourhood	
      property :url	#URL
      property :population	#Population of the neighbourhood
      property :description	#Description
      property :fully_loaded, :default => false
      property :force
      property :links
      property :contact_details
      property :centre
      property :locations
      property :session
      
      # url
      # description
      # title
      def links_parsed(value)
        unless value.nil?
          value.map{|link| Hashie::Mash.new(link)}
        end
      end
      
      # email
      # telephone
      def contact_details_parsed(value)
        unless value.nil?
          Hashie::Mash.new(value)
        end
      end
      
      # @note This may not be exactly in the centre of the neighbourhood
      # latitude
      # longitude
      def centre_parsed(value)
        unless value.nil?
          Hashie::Mash.new(value)
        end
      end
      
      def locations_parsed(value)
        unless value.nil?
          value.map{|location| OldBill::V2::Neighbourhoods::Location.new(location)}
        end
      end
      
      
      # == yak!!!!! refactor me please
      def []=(property, value)
        case property 
          when "locations"
          super(property.to_s, locations_parsed(value))
          when "centre"
          super(property.to_s, centre_parsed(value))
          when "contact_details"
          super(property.to_s, contact_details_parsed(value))
          when "links"
          super(property.to_s, links_parsed(value))
        else
          super
        end
      end
      
      # @return [Array<OldBill::Crimes::StreetLevel>]
      def street_level_crimes
        fully_loaded!
        @street_level_crimes ||= session.street_level_crimes(self.centre.latitude, self.centre.longitude)
      end
      
      def crimes_by_month
        @crimes_by_month ||= session.crimes_by_month(self.force, self.neighbourhood)
      end
      
      def events
        @events ||= session.events(force,id)
      end
      
      def police_officers
        @police_officers ||= session.police_officers(self.force, self.neighbourhood)
      end
      
      def fully_loaded?
        fully_loaded
      end
      
      # if not fully_loaded update its attributes
      def fully_loaded!
        return if fully_loaded
        self.send(:initialize, session.neighbourhood(force, id).to_hash) # hmm calling private method I am MAD
      end
          
    end
  end
end