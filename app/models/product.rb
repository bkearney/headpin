require "candlepin_object"

class Product < CandlepinObject
    
    self.attrs :name, :type, :variant, :version, :arch

    def product_type
      @attributes["type"]
    end  
  
    def cert
      Certificate.find(:one, :from=>"#{self.class.site}#{self.class.collection_name}/#{id}/certificate")
    end
end
