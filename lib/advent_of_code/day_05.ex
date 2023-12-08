defmodule AdventOfCode.Day05 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)

    # Parse the seeds line
    # Parse each section. Delimiter is an empty line. Name of the new section is irrelevant
  end

  def parse_line(line) do
    case String.split(line, ~r/[: ]/) do
      ["seeds", "" | numbers] ->
        {:seeds, Enum.map(numbers, &String.to_integer/1)}

      [""] ->
        nil

      [_, "map" | _] ->
        :map

      [_, _, _] = mapping ->
        [dest, source, range] = Enum.map(mapping, &String.to_integer/1)
        {dest, source, range}
    end
  end

  def part2(_args) do
  end
end
