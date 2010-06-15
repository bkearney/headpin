require "candlepin_object"

class Product < CandlepinObject
    
    self.attrs :name, :type, :variant, :version, :arch

    class << self
      def cert_for(id)
        Certificate.find(:one, :from=>"#{site}#{collection_name}/#{id}/certificate")        
      end
    end
    
    def product_type
      @attributes["type"]
    end  
  
    def product_attributes
      @attributes["attributes"]
    end
    
    def cert
      Product.cert_for(id)  
    end
end
