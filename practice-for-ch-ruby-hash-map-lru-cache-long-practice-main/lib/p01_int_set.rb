class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if num < 0 || num > @store.length
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num] == true
    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].delete(num) if self.include?(num)
  end

  def include?(num)
    return true if self[num].include?(num)
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % self.num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    self.resize! if self.count == num_buckets
    unless self[num].include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    return true if self[num].include?(num)
    false
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
        @store[ele % (self.count * 2)] << ele
      end
    end
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    return @store[num % self.num_buckets]
  end
end
