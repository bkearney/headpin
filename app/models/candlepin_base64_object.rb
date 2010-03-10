require "candlepin_object"
require "base64"

class CandlepinBase64Object < CandlepinObject
  def content
    Base64.decode64(self.value) 
  end
  
  # Posting the value does not like to have the 
  # line breaks
  def content=(content)
    self.value= Base64.encode64(content.strip).gsub("\n","")
  end    
  
  # This is a hack, since in reality we only want the content to 
  # go up
  def encode(options={})
    self.class.format.encode(self.value, options).strip   
  end  
end