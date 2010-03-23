class Status < CandlepinObject
  self.set_collection_name("status")
  self.attrs :result, :version, :hash
  
  def hash_string
    return @attributes["hash"]
  end
end