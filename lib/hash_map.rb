# frozen_string_literal: true

require 'shea-linked_list'

# Maps keys to values inside buckets using hash codes
class HashMap
  def initialize
    @buckets = Array.new(16)
    @load_factor = 0.75
  end

  # produces hash code from key
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def index(key)
    hash_code = hash(key)
    index = hash_code % @buckets.length
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  # assign value to key
  def set(key, value)
    if has?(key)
      overwrite_entry(key, value)
    else
      create_entry(key, value)
      grow if should_grow?
    end
  end

  # returns the value that is assigned to this key
  def get(key)
    i = index(key)
    current_node = @buckets[i]&.head
    while current_node
      node_key, node_value = current_node.value
      return node_value if node_key == key

      current_node = current_node.next_node
    end

    nil
  end

  # returns true or false based on whether or not the key is in the hash map
  def has?(key)
    !get(key).nil?
  end

  # if the given key is in the hash map, it should remove the entry with that key
  # and return the deleted entry’s value
  def remove(key)
    return nil unless has?(key)

    value = get(key)
    i = index(key)
    j = @buckets[i].find([key, value])
    @buckets[i].remove_at(j)
    value
  end

  # returns the number of stored keys in the hash map
  def length
    length = 0
    @buckets.each do |bucket|
      length += bucket.size if bucket
    end
    length
  end

  # removes all entries in the hash map
  def clear
    @buckets = Array.new(16)
  end

  # returns an array containing all the keys inside the hash map
  def keys
    entries = []
    @buckets.each do |bucket|
      current_node = bucket&.head
      while current_node
        entries << current_node.value[0]
        current_node = current_node.next_node
      end
    end
    entries
  end

  # returns an array containing all the values
  def values
    entries = []
    @buckets.each do |bucket|
      current_node = bucket&.head
      while current_node
        entries << current_node.value[1]
        current_node = current_node.next_node
      end
    end
    entries
  end

  # returns an array that contains each key, value pair
  # example: [[first_key, first_value], [second_key, second_value]]
  def entries
    entries = []
    @buckets.each do |bucket|
      current_node = bucket&.head
      while current_node
        entries << current_node.value
        current_node = current_node.next_node
      end
    end
    entries
  end

  private

  def should_grow?
    length > @buckets.length * @load_factor
  end

  def grow
    existing_entries = entries
    @buckets = Array.new(@buckets.length * 2)
    existing_entries.each { |key, value| set(key, value) }
  end

  def create_entry(key, value)
    i = index(key)
    empty_bucket = @buckets[i].nil?
    @buckets[i] = LinkedList.new if empty_bucket
    @buckets[i].append([key, value])
  end

  def overwrite_entry(key, value)
    i = index(key)
    old_value = get(key)
    j = @buckets[i].find([key, old_value])
    @buckets[i].insert_at([key, value], j)
    @buckets[i].remove_at(j + 1)
  end
end
