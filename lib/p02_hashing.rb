class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.join("").to_i.hash
  end
end

class String
  def hash
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    self.chars.map { |char| alphabet.index(char)}.to_a.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
    self.each do |k, v|
      sub = []
      if k.is_a?(Symbol)
        sub << k.to_s
      else
        sub << k
      end
      if v.is_a?(Symbol)
        sub << v.to_s
      else
        sub << v
      end
      arr << sub.hash
    end
    arr.hash
  end

end
