module OldBill
  module V2
    class Force < Hashie::Dash
              
      property :id
      property :name
      property :description
      property :url	#Force website URL
      property :title
      property :telephone	#Force telephone number
      property :id #	Unique force identifier
      property :session
      property :engagement_methods
      
      
      # url Method website URL
      # description Method description
      # title Method title
      def engagement_methods_parsed(value)
        unless value.nil?
          value.map{|engagement_method| Hashie::Mash.new(engagement_method)}
        end
      end
      
      
      def []=(property, value)
        case property 
          when "engagement_methods"
          super(property.to_s, engagement_methods_parsed(value))
        else
          super
        end
      end
            
    end
  end
end