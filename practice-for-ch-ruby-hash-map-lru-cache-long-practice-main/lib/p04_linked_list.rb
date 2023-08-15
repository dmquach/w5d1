include Enumerable
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil 
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next
    self.next.prev = self.prev
  end

end

class LinkedList
  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    current = self.first
    i.times do |j|
      current = current.next
    end
    current
  end

  def first
    if self.empty?
      @head
    else
      @head.next
    end
  end

  def last
    if self.empty?
      @tail
    else
      @tail.prev
    end
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node = Node.new(key,val)
    if self.empty?
      @head.next = node
      @tail.prev = node
      node.next = @tail
      node.prev = @head
    else
      @tail.prev.next = node
      node.prev = @tail.prev
      node.next = @tail
      @tail.prev = node
    end
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      node.remove if node.key == key
    end
  end

  def each
    return nil if self.empty?
    current = self.first
    while current.key != nil
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end