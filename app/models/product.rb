require "candlepin_object"

class Product < CandlepinObject
    
    # Treat the attributes as a hashmap, and
    # not real objects
    def load(attributes)
        myAttributes = attributes.delete("attributes")
        if myAttributes
             myAttributes = myAttributes.dup
        else
            myAttributes = Hash.new()
        end
        @attributes["productAttributes"] = myAttributes
        super
    end
end
