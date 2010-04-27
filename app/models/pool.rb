require "candlepin_object"

class Pool < CandlepinObject
    self.attrs :productId, :productName, :quantity, :startDate, :endDate, :consumed
end
