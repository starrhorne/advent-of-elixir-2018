IO.puts("Day 1, Part 1: #{Day1.solve_part_1(File.stream!("inputs/day1_input.txt"))}")
IO.puts("Day 1, Part 2: #{Day1.solve_part_2(File.stream!("inputs/day1_input.txt"))}")
IO.puts("Day 2, Part 1: #{Day2.solve_part_1(File.stream!("inputs/day2_input.txt"))}")
IO.puts("Day 2, Part 2: #{Day2.solve_part_2(File.stream!("inputs/day2_input.txt"))}")
IO.puts("Day 3, Part 1: #{Day3.solve_part_1(File.stream!("inputs/day3_input.txt"))}")
[id] = Day3.solve_part_2(File.stream!("inputs/day3_input.txt"))
IO.puts("Day 3, Part 2: #{id}")
