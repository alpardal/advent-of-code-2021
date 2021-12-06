require_relative 'common'

ages = read_input.first.split(',').map(&method(:Integer))
age_counts = ages.tally

value_sum = ->(_k, o, n) { o + n }
sum_merge = ->(h1, h2) { h1.merge(h2, &value_sum) }

tick = ->(counts) {
  counts.map do |age, count|
    if age.zero?
      { 6 => count, 8 => count }
    else
      { age - 1 => count }
    end
  end.reduce(&sum_merge)
}
generations = ->(seed) { Enumerator.produce(seed, &tick).lazy }

### part 1 ###

days = 80
population = generations[age_counts].drop(days).first
check 'part 1',
      population.values.sum,
      346063

### part 2 ###

days = 256
population = generations[age_counts].drop(days).first
check 'part 2',
      population.values.sum,
      1572358335990
