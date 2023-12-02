defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1 sample" do
    input = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    assert 142 == part1(input)
  end

  test "part2 sample" do
    input = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    assert 281 == part2(input)
  end

  @samples [
    {"two1nine", 29},
    {"eightwothree", 83},
    {"abcone2threexyz", 13},
    {"xtwone3four", 24},
    {"4nineeightseven2", 42},
    {"zoneight234", 14},
    {"7pqrstsixteen", 76}
  ]

  for {input, output} <- @samples do
    test "part 2 parses #{input} as #{output}" do
      assert unquote(output) == part2(unquote(input))
    end
  end
end
