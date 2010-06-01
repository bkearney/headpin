require "json"
class GridData
  attr_accessor :rows, :page, :total, :records
  
  def set_records(recs)
    self.rows=[]
    recs.each do |rec|
      self.rows << rec.attributes
    end
    self.page= 1
    self.total=1
    self.records=recs.size()
  end
end

