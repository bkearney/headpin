require "candlepin_object"
require "openssl"

class IdentityCertificate < CandlepinObject
  self.attrs :key, :cert
  
  def keyString
    OpenSSL::PKey::RSA.new(self.key).to_text
  end
  
  def certificateString
    OpenSSL::X509::Certificate.new(self.cert).to_text
  end    
end