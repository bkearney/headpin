require "candlepin_object"

class Pool < CandlepinObject
    self.context= "pool"
    self.attrs :productId, :maxMembers, :startDate, :endDate, :activeSubscription
end
