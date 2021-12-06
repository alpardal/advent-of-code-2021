require_relative 'common'

lines = read_input.map { |line| line.split(/,| -> /).map(&method(:Integer)) }

def take_until_inclusive(col, pred)
  Enumerator.new do |y|
    col.each do |e|
      y << e
      break if pred.call(e)
    end
  end
end

def coverage_count(lines)
  lines.flat_map do |x1, y1, x2, y2|
    dx = (x2 - x1).clamp(-1, 1)
    dy = (y2 - y1).clamp(-1, 1)

    coords = Enumerator.produce([x1, y1]) { |x, y| [x + dx, y + dy] }
    take_until_inclusive(coords, ->(c) { c == [x2, y2] }).to_a
  end.tally
end

greater_than = ->(val, arg) { arg > val }.curry
two_or_more = greater_than[1]

### part 1 ###

is_diagonal = ->((x1, y1, x2, y2)) { x1 != x2 && y1 != y2 }
counts = coverage_count(lines.reject(&is_diagonal))

check 'part 1',
      counts.values.select(&two_or_more).size,
      5576

### part 2 ###

counts = coverage_count(lines)
check 'part 2',
      counts.values.select(&two_or_more).size,
      18144
