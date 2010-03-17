require "candlepin_object"

class Pool < CandlepinObject
    self.attrs :productId, :quantity, :startDate, :endDate, :consumed
end
