require_relative 'p04_linked_list'
include Enumerable

class HashMap
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
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
    self.store.length
  end

  def store=(val)
    @store = val
  end

  def resize!
    num = num_buckets * 2
    list = Array.new(num) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |node|
        list[node.key.hash % num].append(node.key, node.val)
      end
    end
    @store = list
  end

  def bucket(key)
    self.store[key.hash % num_buckets]
  end
end
