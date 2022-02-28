class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self[key].include?(key)
      resize! if @count == num_buckets
      self[key] << key 
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    self.store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def store=(val)
    @store = val
  end

  def resize!
    num = num_buckets * 2
    arr = Array.new(num) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        arr[el.hash % num] << el
      end
    end
    @store = arr
  end
end
