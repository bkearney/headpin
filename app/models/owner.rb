require "candlepin_object"

class Owner < CandlepinObject
    self.attrs :name
    
    def my_pools
      return Pool.find(:all, :params => {:owner => self.Id})
    end
end
