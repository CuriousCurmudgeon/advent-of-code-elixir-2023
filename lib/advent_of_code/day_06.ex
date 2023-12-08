defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn x ->
      Regex.scan(~r/\d+/, x) |> List.flatten() |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(&number_of_ways_to_win/1)
    |> Enum.reduce(&(&1 * &2))
  end

  defp number_of_ways_to_win({time, distance}, hold_time \\ 1) do
    if hold_time * (time - hold_time) > distance do
      time - hold_time - hold_time + 1
    else
      number_of_ways_to_win({time, distance}, hold_time + 1)
    end
  end

  def part2(_args) do
  end
end
