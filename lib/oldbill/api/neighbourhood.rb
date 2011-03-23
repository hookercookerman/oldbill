module OldBill
  module Api
    module Neighbourhood
      
      
      # @param [String] force
      # @return [Array<OldBill::Neighbourhood>] only partially loaded
      def neighbourhoods(force, params = {})
        api_call(:get, "/#{force}/neighbourhoods", params) do |response|
          response.map{|neighbourhood| OldBill::V2::Neighbourhood.new(merge_session!(neighbourhood.merge({:force => force, :fully_loaded => false}))) }
        end
      end
      
      # @param [String] force
      # @param [String] neighbourhood
      # @return [Array<OldBill::Neighbourhood>]
      def neighbourhood(force, neighbourhood, params = {})
        api_call(:get, "/#{force}/#{neighbourhood}", params) do |response|
          OldBill::V2::Neighbourhood.new(merge_session!(response.merge({:force => force, :fully_loaded => true})))
        end
      end
      
      # @param [String] force
      # @param [String] neighbourhood
      # @return [Array<OldBill::V2::Neighbourhoods::Event>]
      def events(force, neighbourhood, params = {})
        api_call(:get, "/#{force}/#{neighbourhood}/events", params) do |response|
          response.map{|event| OldBill::V2::Neighbourhoods::Event.new(merge_session!(event))}
        end
      end
      
      
      # @param [String] force
      # @param [String] neighbourhood
      # @return [Array<OldBill::V2::Neighbourhoods::PoliceOfficer>]
      def police_officers(force, neighbourhood, params = {})
        api_call(:get, "/#{force}/#{neighbourhood}/people", params) do |response|
           response.map{|event| OldBill::V2::Neighbourhoods::PoliceOfficer.new(merge_session!(event))}
         end
      end
      
      
      # @param [Float] lat
      # @param [Float] lng
      # @return [OldBill::V2::Neighbourhoods::Locator]
      def locate(lat, lng, params = {})
        api_call(:get, "/locate-neighbourhood", params.merge!({:q => "#{lat},#{lng}"})) do |response|
           OldBill::V2::Neighbourhoods::Locator.new(merge_session!(response))
         end
       rescue NotFoundError
         nil
      end
      
    end
  end
end