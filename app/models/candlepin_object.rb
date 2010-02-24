#require "candlepin_rest"

# See http://www.quarkruby.com/2008/3/11/consume-non-rails-style-rest-apis
# for much of the detils behind this method
class CandlepinObject < ActiveResource::Base

    #include CandlepinRest
    
    self.site = "http://localhost:8080"
    self.format = :json

    class << self 

        # would be nice to make these be more rails like.         
        def context=(context)
            @context=context
        end
        
        def has_many(*children)
            @children = children.to_a
        end
        
        def child_relationships
            @children.nil? ? [] : @children
        end   
        
        def attrs(*attrs)
            @attrs = attrs.to_a
        end
        
        def default_attrs
            @attrs.nil? ? [] : @attrs
        end  
        
        def element_path(id, prefix_options = {}, query_options = nil) 
            "/candlepin/#{@context}/#{id}"
        end
        
        def collection_path(prefix_options = {}, query_options = nil) 
            "/candlepin/#{@context}/"
        end    
        
        def instantiate_collection(collection, prefix_options = {})
            Array items = Array.new() 
            if (! collection.nil?)
                # Need to make the result an array of hashmaps in order to 
                # parse it well.
                inner_collection = Array.new()
                # handle the case of {key => {hash of attributes}} which is single object                
                inner_collection = collection["#{@context}"] if collection.is_a?(Hash)
                # Handle the case of a single string. This may be a bit of a hack :)
                inner_collection = {"value" => collection} if collection.is_a?(String)                   
                # handle the case of {key => [array of hashses]} which is a collection of objects
                inner_collection = [] << inner_collection if inner_collection.is_a?(Hash)
                inner_collection.each do |record|
                    items << instantiate_record(record, prefix_options)
                end
            end
            
            items
        end
    end
    
    def load(attributes)
        new_attributes = attributes 
        # Handle the case of a single string. This may be a bit of a hack :)
        new_attributes = {"value" => attributes} if attributes.is_a?(String)   
        # Put in the default relationsips
        self.class.child_relationships.each do |child|
            childString = child.to_s
            if (new_attributes.has_key?(childString))
                new_attributes[childString] = [new_attributes[childString]] if new_attributes[childString].is_a?(Hash)
            else
                new_attributes[childString]= [] 
            end
        end
        # Put in the default attributes
        self.class.default_attrs.each do |attr|
            attrString = attr.to_s
            new_attributes[attrString]= "" if !new_attributes.has_key?(attrString)
        end
        super(new_attributes)
    end
end
