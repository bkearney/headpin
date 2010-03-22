class ConsumerFacts < CandlepinObject
  
  class Entry < CandlepinObject
    self.attrs :key, :value
  end
  
end