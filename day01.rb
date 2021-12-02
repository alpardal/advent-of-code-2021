require_relative 'common'

depths = read_input.map(&method(:Integer))

diff = ->((a, b)) { b - a }

increments = ->(values) {
  values.each_cons(2)
        .map(&diff)
        .select(&:positive?)
}

### part 1 ###

check 'part 1',
      increments[depths].size,
      1766

### part 2 ###

window_sums = depths.each_cons(3).map(&:sum)
check 'part 2',
      increments[window_sums].size,
      1797
