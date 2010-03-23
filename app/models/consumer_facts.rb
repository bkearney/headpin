class ConsumerFacts < CandlepinObject
  
  self.has_many :entry
  
  class Entry < CandlepinObject
    self.attrs :key, :value
  end
  
end