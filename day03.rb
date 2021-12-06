require_relative 'common'

report = read_input

first = :first.to_proc
last = :last.to_proc
sort_by_frequency = ->(vals) {
  # use `reverse` so we sort by count and then value
  vals.tally.sort_by(&:reverse).map(&first)
}
bits_to_int = ->(bits) { Integer(bits.join, 2) }

most_frequent = sort_by_frequency >> last
least_frequent = sort_by_frequency >> first

bits = report.map(&:chars)
bit_slices = bits[0].zip(*bits[1..])

### part 1 ###

gamma = bit_slices.map(&most_frequent).then(&bits_to_int)
epsilon = bit_slices.map(&least_frequent).then(&bits_to_int)
power = gamma * epsilon

check 'part 1', power, 2250414

### part 2 ###

def search(entries, criterion, n = 0)
  return entries.first if entries.size == 1

  nth = ->(c) { c[n] }
  target = entries.map(&nth).then(&criterion)
  entries = entries.select { |c| nth[c] == target }
  search(entries, criterion, n.succ)
end

ox_rating = search(bits, most_frequent).then(&bits_to_int)
co2_rating = search(bits, least_frequent).then(&bits_to_int)
life_support_rating = ox_rating * co2_rating

check 'part 2',
      life_support_rating,
      6085575
