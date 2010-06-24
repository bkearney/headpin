require "candlepin_object"

class Owner < CandlepinObject
    self.attrs :key, :displayName
    
    def my_pools
      return Pool.find(:all, :params => {:owner => self.Id})
  end
  
  def refresh_subscriptions
        url = "#{self.class.prefix({})}#{self.class.collection_name}/#{self.key}/subscriptions#{self.class.__send__(:query_string, {})}"
        connection.put(url, '', self.class.headers)        
  end
end
