require "candlepin_object"

class Owner < CandlepinObject
    self.context= "owner"
    self.has_many :entitlementPools
end
