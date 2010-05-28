class Content < CandlepinObject
     self.attrs :id, :type, :label, :name, :vendor, :contentUrl, :gpgUrl, :created, :updated
     
    def content_hash
      @attributes["hash"]
    end
    def content_type
      @attributes["type"]
    end       
end