class Constants
  @@site ="http://localhost:8080/candlepin"
  @@user = "f"
  @@password = "f"
  
  def self.site
    return @@site
  end
  
  def self.site=(newSite)
    @@site = newSite
  end
  
  def self.user
    return @@user
  end
  
  def self.user=(newUser)
    @@user = newUser
  end  
  
  def self.password
    return @@password
  end
  
  def self.password=(newPassword)
    @@password = newPassword
  end    
end