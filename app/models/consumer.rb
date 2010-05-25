require "candlepin_object"

class Consumer < CandlepinObject
  self.attrs :name, :uuid, :type, :facts
  
  def type_id
    return consumertype.id if consumertype
    return nil
  end
  
  def consumertype
    return @attributes["type"]
  end
  
  def type_label
    return consumertype.label if consumertype
    return nil
  end  
  
  def element_path(options = nil)
    self.class.element_path(self.uuid, options || prefix_options)
  end    
  
  def keyString
    self.idCert.keyString if self.idCert
  end
  
  def certificateString
    self.idCert.certificateString if self.idCert
  end  
  
  def my_entitlements
    return Entitlement.find(:all, :params => {:consumer => self.uuid})
  end  
  
  #TODO THIS IS A HACK
  def load(attributes)
    super(attributes)
    if self.facts.is_a?(String)
      self.facts= ConsumerFacts.new() 
      self.facts.entry = []
    end
  end
end