class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    arr = []
    self.each.with_index do |val, index|
      arr << (val << index).to_s(2).to_i
    end
    arr.sum
  end
end

class String
  def hash
    arr = self.split("")
    new_arr = []
    arr.each.with_index do |char, index|
      new_arr << char.ord * (index + 4)
    end

    new_arr.join("").to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |key, value|
      arr << key.hash * value.hash
    end
    arr.sum
  end
end
