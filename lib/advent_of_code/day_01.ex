defmodule AdventOfCode.Day01 do
  def part1(input) do
    String.split(input)
    |> Enum.reduce(0, &(calibrate(&1) + &2))
  end

  def part2(_args) do
  end

  defp calibrate(input) do
    input
    |> String.replace(~r/[^0-9]/, "")
    |> then(fn x -> (String.first(x) <> String.last(x)) |> Integer.parse() end)
    |> elem(0)
  end
end
