require "json"

class TreeNode
  attr_accessor :data, :attr, :state, :children
  
  def initialize(hash={})
    @attr = hash[:attr] || {}
    @attr[:id] = hash[:id] if hash[:id]
    @children = hash[:children] || nil
    @state = hash[:state] || nil
    @data = hash[:data] || "none"
  end
  
  def <<(node) 
    @children = [] if @children.nil?
    @children << node
  end
  
  def to_json(a) 
    attrs = {}
    attrs["data"] = @data
    attrs["attr"] = @attr
    attrs["state"] = @state if !@state.nil?
    attrs["children"] = @children if !@children.nil?      
    attrs.to_json(a)
  end
end