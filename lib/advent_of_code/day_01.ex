defmodule AdventOfCode.Day01 do
  def part1(input) do
    String.split(input)
    |> Enum.map(fn x -> String.replace(x, ~r/[^0-9]/, "") end)
    |> Enum.map(fn x -> (String.first(x) <> String.last(x)) |> Integer.parse() |> elem(0) end)
    |> Enum.sum()
  end

  def part2(_args) do
  end
end
