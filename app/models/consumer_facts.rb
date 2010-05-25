class ConsumerFacts < CandlepinObject
  
  self.has_many :entry
  
  class Entry < CandlepinObject
    self.attrs :key, :value
  end
  
  def load(attributes)
    self.entry = []
    attributes.keys.each do |key|
      fact = Entry.new
      fact.key = key
      fact.value = attributes[key]
      entry << fact
    end
  end  
  
  def encode(options={})
    self.class.format.encode(as_json(options), options)
  end    
  
  def as_json(options=nil)
    items = {}
    entry.each do |fact|
      items[fact.key] = fact.value
    end
    items
  end
  
end