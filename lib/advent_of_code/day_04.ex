defmodule AdventOfCode.Day04 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&find_winners/1)
    |> Enum.map(&MapSet.size/1)
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.reduce(0, fn x, acc -> :math.pow(2, x - 1) + acc end)
  end

  defp find_winners(line) do
    [winners, mine] =
      line
      |> String.split([":", "|"])
      |> tl()
      |> Enum.map(&String.split/1)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(winners, mine)
  end

  def part2(_args) do
  end
end
