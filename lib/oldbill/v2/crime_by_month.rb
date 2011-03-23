module OldBill
  module V2
    class CrimeByMonth < Hashie::Trash
      
      def self.property(property_name, options = {})
        if options[:from] && options[:from] =~ /-/
          translations << options[:from].to_sym
          define_method "#{options[:from]}=" do |val|
            self[:"#{property_name}"] = val
          end
          options.delete(:from)
          super(property_name, options)
        else
          super
        end
      end
      
      property :month
      property :robbery
      property :burglary
      property :anti_social_behaviour, :from => "anti-social-behaviour"
      property :other_crime, :from => "other-crime"
      property :all_crime, :from => "all-crime"
      property :vehicle_crime, :from => "vehicle-crime"
      property :violent_crime, :from => "violent-crime"
      property :session
    
    end
  end
end