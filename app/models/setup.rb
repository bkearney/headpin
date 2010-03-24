class Setup
  attr_accessor :site, :user, :password
  
  def initialize(params=nil)
    if (!params.nil?)
      self.site = params["site"]
      self.user = params["user"]
      self.password = params["password"]      
    end
  end
end