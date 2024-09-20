# frozen_string_literal: true

require_relative '../lib/hash_map'

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts '--- initial entries ---'
p test.entries

# overwrite
test.set('lion', 'gray')
test.set('dog', 'blue')

puts '--- overwriting ---'
p test.entries

# growing
test.set('moon', 'silver')

puts '--- growing ---'
p test.entries

# overwrite again
test.set('moon', 'white')
test.set('apple', 'green')
p test.entries
