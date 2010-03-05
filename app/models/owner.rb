require "candlepin_object"

class Owner < CandlepinObject
    def my_pools
      return Pool.find(:all, :params => {:owner => self.Id})
    end
end
