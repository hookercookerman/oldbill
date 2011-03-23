module OldBill
  module Api
    module Crime
      
      # @return [Array<Hashie::Dash>] #id #name
      def forces
        api_call(:get, "/forces") do |response|
          response.map{|category| Hashie::Mash.new(merge_session!(category))}
        end
      end
      
      # @return [OldBill::Force>] #id #name
      def force(force, params = {})
        api_call(:get, "/forces/#{force}", params) do |response|
          OldBill::V2::Force.new(merge_session!(response))
        end
      end
      
      # @param [String] force
      # @param [String] neighbourhood
      # @return [Array<OldBill::CrimeByMonth>]
      def crimes_by_month(force, neighbourhood, params = {})
        api_call(:get, "/#{force}/#{neighbourhood}/crime", params) do |response|
          (response.empty? ? [] : response["crimes"].map{|crime_by_month| OldBill::V2::CrimeByMonth.new(merge_session!({:month => crime_by_month[0]}.merge(crime_by_month[1])))})
        end
      end

      # @param [Float] Latitude of the requested crime area
      # @param [Float] Longitude of the requested crime area
      # @return [Array<OldBill::Crimes::StreetLevel>]
      def street_level_crimes(lat, lng, params = {})
        api_call(:get, "/crimes-street/all-crime", params.merge!({:lat => lat, :lng => lng})) do |response|
          response.map{|street_crime| OldBill::V2::Crimes::StreetLevel.new(merge_session!(street_crime))}
        end
      end
      
      # @return [Array<Hashie::Dash>] #url #name
      def crime_categories
        api_call(:get, "/crime-categories") do |response|
          response.map{|category| Hashie::Mash.new(merge_session!(category))}
        end
      end
      
    end
  end
end