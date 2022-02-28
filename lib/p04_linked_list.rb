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
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    node = @head.next
    j = 0
    until node.next == nil
      if i == j
        return node
      end
      j += 1
      node = node.next
    end
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head ? true : false
  end

  def get(key)
    node = @head.next
    until node.next == nil
      if node.key == key
        return node.val
      end
      node = node.next
    end
    nil
  end

  def include?(key)
    node = @head.next
    until node.next == nil
      if node.key == key
        return true
      end
      node = node.next
    end
    false
  end

  def append(key, val)
    prev_node = @tail.prev
    node = Node.new(key, val)
    prev_node.next = node
    node.prev = prev_node
    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    node = @head.next
    until node.next == nil
      if node.key == key
        return node.val = val
      end
      node = node.next
    end
    false
  end

  def remove(key)
    node = @head.next
    until node.next == nil
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node
        break
      end
      node = node.next
    end
  end

  def each
    node = @head.next
    until node.next == nil
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
