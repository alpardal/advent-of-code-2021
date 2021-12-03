require_relative 'common'

update_in = ->(hash, key, f) {
  hash.merge(key => f.call(hash[key]))
}
inc_by = ->(amount, val) { val + amount }.curry

parse = ->(line) {
  op, x = line.split(' ')
  [op.to_sym, Integer(x)]
}

course = read_input.map(&parse)

### part 1 ###

pt1_update = ->(pos, (op, x)) {
  case op
    in :forward
      update_in[pos, :horiz, inc_by[x]]
    in :up
      update_in[pos, :depth, inc_by[-x]]
    in :down
      update_in[pos, :depth, inc_by[x]]
  end
}

start = { horiz: 0, depth: 0 }

final1 = course.reduce(start, &pt1_update)
check 'part 1',
      final1.values.reduce(:*),
      1660158

### part 2 ###

start = { horiz: 0, depth: 0, aim: 0 }

pt2_update = ->(pos, (op, x)) {
  case op
  in :forward
    update_in[pos, :horiz, inc_by[x]].then do |new_pos|
      update_in[new_pos, :depth, inc_by[new_pos[:aim] * x]]
    end
  in :up
    update_in[pos, :aim, inc_by[-x]]
  in :down
    update_in[pos, :aim, inc_by[x]]
  end
}

final2 = course.reduce(start, &pt2_update)
check 'part 2',
      final2.values_at(:horiz, :depth).reduce(:*),
      1604592846
