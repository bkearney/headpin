require "candlepin_object"

class Product < CandlepinObject
    
    self.attrs :name, :type, :variant, :version, :arch

    def product_type
      @attributes["type"]
    end  
end
