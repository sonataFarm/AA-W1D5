class PolyTreeNode
  attr_reader :parent, :children, :value
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(new_parent)
    prev_parent = parent
    prev_parent.children.delete(self) if prev_parent

    @parent = new_parent
    parent.children << self if new_parent
  end

  def add_child(new_child)
    unless has_child?(new_child)
      new_child.parent = self
    end
  end

  def remove_child(child)
    raise "Child does not exist :(" unless self.has_child?(child)

    self.children.delete(child)
    child.parent = nil

  end

  def has_child?(child)
    # require 'byebug'; debugger
    self.children.include?(child)
  end

  def inspect
    children_to_print =
      if children.empty?
        'none'
      else
        children.map(&:to_s).inspect
      end
    parent_to_print =
      if parent.nil?
        'none'
      else
        parent.to_s
      end
    "{value: #{value}, parent: #{parent_to_print}, children: #{children_to_print} }"
  end

  def to_s
    value.to_s
  end

  def dfs(target)
    if value == target
      return value
    else
      children.each do |child|
        child_dfs = child.dfs(target)
        return child if child_dfs == target
      end
    end
    false
  end
end
