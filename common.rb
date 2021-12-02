def check(label, actual, expected)
  if actual == expected
    puts "\e[32m✓\e[0m #{label} OK: #{actual}"
  else
    puts "\e[31m✗\e[0m #{label} FAILED: expected #{expected.inspect}, got #{actual.inspect}"
  end
end

def read_input
  File.basename($0).sub(/\.rb$/, '').then do |file|
    File.readlines("inputs/#{file}").map(&:chomp)
  end
end
