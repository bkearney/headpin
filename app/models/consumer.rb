require "candlepin_object"
require "openssl"

class Consumer < CandlepinObject
  self.attrs :name, :uuid, :type
  
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
    OpenSSL::PKey::RSA.new(self.idCert.key).to_text if self.idCert
  end
  
  def certificateString
    OpenSSL::X509::Certificate.new(self.idCert.cert).to_text if self.idCert
  end  
end