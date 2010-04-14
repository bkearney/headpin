class Status < CandlepinObject
  self.set_collection_name("status")
  self.attrs :result, :version, :release
end