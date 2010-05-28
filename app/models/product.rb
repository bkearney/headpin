require "candlepin_object"

class Product < CandlepinObject
    
    def product_hash
      @attributes["hash"]
    end

  def product_attributes
    @attributes["attributes"]
  end
end
