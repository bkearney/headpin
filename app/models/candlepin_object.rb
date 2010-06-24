#require 'mappings'
# See http://www.quarkruby.com/2008/3/11/consume-non-rails-style-rest-apis
# for much of the detils behind this method
class CandlepinObject < ActiveResource::Base
  
  self.site = Constants.site
  self.user = Constants.user
  self.password = Constants.password
  self.format = :json
  
  #import mappings
  MAPPINGS = {"Type" => "Consumertype",
    "IdCert" => "Certificate",  
    "Facts" => "ConsumerFacts",     
    "ChildProduct" => "Product",
    "EnabledContent" => "Content",
    "Cert" => "Content",     
  }
  
  class << self 
    
    def const_get(sym)
      return Kernel.const_get(MAPPINGS[sym]) if MAPPINGS[sym]
      return super(sym)
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
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
          "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
    end
    
    
    def collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
         "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
    end
    
    
    def instantiate_collection(collection, prefix_options = {})
      Array items = Array.new() 
      if (! collection.nil?)
        # Need to make the result an array of hashmaps in order to 
        # parse it well.
        inner_collection = Array.new()       
        inner_collection = collection if collection.is_a?(Array)
        
        # handle the case of {key => {hash of attributes}} which is single object
        # as well as {hash of attributes}
        if (collection.is_a?(Hash))
          if (collection.key?(element_name) && collection.length == 1)
            inner_collection << collection[element_name]
          else
            inner_collection << collection
          end
        end
        # Handle the case of a single string. This may be a bit of a hack :)
        inner_collection << {"value" => collection} if collection.is_a?(String)                   
        # We need this to be an array of hashs {key => [array of hashses]}, 
        # so if it is a single hash we array it.
        #inner_collection = [] << inner_collection if inner_collection.is_a?(Hash)   
        inner_collection.each do |record|
          items << instantiate_record(record, prefix_options)
        end
      end
      
      items
    end
  end
  
  def load(attributes)
    
    # Need to handle the case where the attribute is actually a hash
    # with a single value which is the element name. In that case, the 
    # real attributes are actually the children
    if (attributes.size == 1 && attributes[self.class.element_name])
      new_attributes = attributes[self.class.element_name]
    else
      new_attributes = attributes
    end
    
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
  
  def Id
    self.id
  end
  
  def encode(options={})
    self.class.format.encode(attributes, options)
  end  
 
  def update_attributes(new_attributes)
    @attributes.each do |key, value| 
      @attributes[key] = new_attributes[key] if new_attributes[key]
      @attributes[key] = new_attributes[key] if new_attributes[key.to_sym]      
    end
  end

  def put(method_name, options = {}, body = '')
    url = "#{self.class.prefix(prefix_options)}#{self.class.collection_name}/#{id}/#{method_name}#{self.class.__send__(:query_string, options)}"
    connection.put(url, body, self.class.headers)
  end

end
