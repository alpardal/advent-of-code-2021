require_relative 'common'

input = read_input

numbers = input.first.split(',').map(&method(:Integer))
board_strs = input.drop(1).slice_before(&:empty?)
                  .map { |v| v.drop(1) }.to_a
boards = board_strs.map { |b| b.join(' ').split(/(?<=\d)\s+/).map(&method(:Integer)) }
board_size = board_strs.first.size

all_contained_in = ->(col, vals) { (vals - col).empty? }.curry
push_into = ->(col, val) { col << val }.curry
rows = ->(size) { (0...size**2).each_slice(size) }
cols = ->(size) { (0...size).map { |s| (s..).step(size).take(size) } }

row_marked = ->(marks) { rows[board_size].any?(&all_contained_in[marks]) }
col_marked = ->(marks) { cols[board_size].any?(&all_contained_in[marks]) }
is_winner = ->(marks) { row_marked[marks] || col_marked[marks] }

get_winners = ->(boards, numbers) {
  all_marks = boards.map { [] }
  winners = {}

  numbers.each_with_index do |n, i|
    boards.each_with_index do |board, bi|
      next if winners.key?(bi)

      board_marks = all_marks[bi]
      board.index(n)&.then(&push_into[board_marks])
      winners[bi] = i if is_winner[board_marks]
    end
  end

  # ruby hashes conserve insertion order
  winners.to_a.map { |bi, i| [boards[bi], i] }
}

winners = get_winners[boards, numbers]

### part 1 ###

winner, last_n = winners.first
picked = numbers[0..last_n]
unmarked = winner.reject { |n| picked.include?(n) }

check 'part 1',
      unmarked.sum * picked.last,
      32_844

### part 2 ###

last_winner, last_n = winners.last
picked = numbers[0..last_n]
unmarked = last_winner.reject { |n| picked.include?(n) }
check 'part 2',
      unmarked.sum * picked.last,
      4920
