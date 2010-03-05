require "candlepin_object"

class Pool < CandlepinObject
    self.attrs :productId, :maxMembers, :startDate, :endDate, :activeSubscription
end
