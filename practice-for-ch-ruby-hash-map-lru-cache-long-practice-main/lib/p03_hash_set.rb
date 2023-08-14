class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self.resize! if self.count == num_buckets
    unless self[key].include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    return true if self[key].include?(key)
    false
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    copy = @store.dup
    @store = Array.new(@count * 2) {Array.new}
    copy.each do |array|
      array.each do |ele|
        @store[ele.hash % (self.count * 2)] << ele
      end
    end
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num.hash % self.num_buckets]
  end
end