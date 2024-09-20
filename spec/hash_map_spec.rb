# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/hash_map'

describe 'set' do
  it 'sets a new value' do
    map = HashMap.new
    map.set('Jon', 'podcast host')
    expect(map.get('Jon')).to be('podcast host')
  end

  it 'overwrites an exisiting value' do
    map = HashMap.new
    map.set('Jon', 'podcast host')
    map.set('Andy', 'AI researcher')
    map.set('Jon', 'first boot')
    expect(map.get('Jon')).to be('first boot')
  end
end

describe 'get' do
  it "returns a key's value" do
    map = HashMap.new
    map.set('Andy', 'AI researcher')
    expect(map.get('Andy')).to be('AI researcher')
  end
end

describe 'has?' do
  it 'returns true if key is in the hash map' do
    map = HashMap.new
    map.set('Tony', 'cop')
    expect(map.has?('Tony')).to be(true)
  end

  it 'returns false if key is not in the has map' do
    map = HashMap.new
    map.set('Sandra', 'queen')
    expect(map.has?('Rob')).to be(false)
  end
end

describe 'remove' do
  it 'removes the key/value pair' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    expect(map.entries).to contain_exactly(%w[Richard Borneo], ['Parvati', 'Cook Islands'])

    map.remove('Richard')
    expect(map.entries).to contain_exactly(['Parvati', 'Cook Islands'])
  end
end

describe 'length' do
  it 'returns correct amount of entries' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    map.set('Sandra', 'Pearl Islands')
    expect(map.length).to be(3)
  end

  it 'returns correct amount of entries again' do
    map = HashMap.new
    map.set('apple', 'red')
    map.set('banana', 'yellow')
    map.set('carrot', 'orange')
    map.set('dog', 'brown')
    map.set('elephant', 'gray')
    map.set('frog', 'green')
    map.set('grape', 'purple')
    map.set('hat', 'black')
    map.set('ice cream', 'white')
    map.set('jacket', 'blue')
    map.set('kite', 'pink')
    map.set('lion', 'golden')
    map.set('moon', 'silver')
    expect(map.length).to be(13)
  end

  it 'returns 0 for empty map' do
    map = HashMap.new
    expect(map.length).to be(0)
  end
end

describe 'clear' do
  it 'removes all entries' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    map.set('Sandra', 'Pearl Islands')
    map.clear
    expect(map.length).to be(0)
  end
end

describe 'keys' do
  it 'returns array of all keys' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    map.set('Sandra', 'Pearl Islands')
    expect(map.keys).to contain_exactly('Richard', 'Parvati', 'Sandra')
  end

  it 'returns empty array for map with no entries' do
    map = HashMap.new
    expect(map.keys).to eq([])
  end
end

describe 'values' do
  it 'returns array of all values' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    map.set('Sandra', 'Pearl Islands')
    expect(map.values).to contain_exactly('Borneo', 'Cook Islands', 'Pearl Islands')
  end

  it 'returns empty array for map with no entries' do
    map = HashMap.new
    expect(map.values).to eq([])
  end
end

describe 'entries' do
  it 'returns array of all entries' do
    map = HashMap.new
    map.set('Richard', 'Borneo')
    map.set('Parvati', 'Cook Islands')
    map.set('Sandra', 'Pearl Islands')
    expect(map.entries).to contain_exactly(%w[Richard Borneo], ['Parvati', 'Cook Islands'],
                                           ['Sandra', 'Pearl Islands'])
  end

  it 'returns empty array for map with no entries' do
    map = HashMap.new
    expect(map.entries).to eq([])
  end
end

describe 'works with many entries' do
  let(:entries) do
    [['moon', 'silver'], ['carrot', 'orange'], ['frog', 'green'], ['banana', 'yellow'], ['grape', 'purple'],
     ['ice cream', 'white'], ['jacket', 'blue'], ['kite', 'pink'], ['elephant', 'gray'], ['apple', 'red'],
     ['hat', 'black'], ['dog', 'blue'], ['lion', 'golden']]
  end

  it 'gets correct value' do
    map = HashMap.new
    entries.each { |key, value| map.set(key, value) }
    expect(map.get('lion')).to be('golden')
  end
end
