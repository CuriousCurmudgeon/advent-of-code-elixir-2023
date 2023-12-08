defmodule Mix.Tasks.D06.P2 do
  use Mix.Task

  import AdventOfCode.Day06

  @shortdoc "Day 06 Part 2"
  def run(args) do
    input = """
    Time:        62     64     91     90
    Distance:   553   1010   1473   1074
    """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
