require "candlepin_object"

class Consumer < CandlepinObject
      self.attrs :name, :id, :uuid
end