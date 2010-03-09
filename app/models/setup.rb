class Setup
  attr_accessor :site
  
  def initialize(params=nil)
    if (!params.nil?)
      self.site = params["site"]
    end
  end
end