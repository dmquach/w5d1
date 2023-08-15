require_relative 'p04_linked_list'
include Enumerable

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
      self.resize! if self.count == num_buckets
      if !bucket(key).include?(key)
        bucket(key).append(key, val)
        @count += 1
      else
        bucket(key).update(key, val)
      end
  end

  def get(key)
    bucket(key).each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def delete(key)
    @count -= 1
    bucket(key).remove(key)
  end

  def each
    @store.each do |list|
     # yield nil if list.empty?
      current = list.first
      while current.key != nil
        yield current
        current = current.next
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    copy = @store.dup
    @store = Array.new(@count * 2) { LinkedList.new }
    copy.each do |list|
      list.each do |node|
        @store[bucket(node.key)].append(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    return @store[key.hash % self.num_buckets]
  end
end
