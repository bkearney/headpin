require "candlepin_object"

class EntitlementPool < CandlepinObject
    self.context= "entitlementPool"
    self.attrs :productId, :maxMembers, :startDate, :endDate
end
