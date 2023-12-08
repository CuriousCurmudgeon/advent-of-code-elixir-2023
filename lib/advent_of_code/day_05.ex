defmodule AdventOfCode.Day05 do
  def part1(input) do
    [seeds | map_lines] =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
      |> Enum.filter(& &1)

    map_groups =
      map_lines
      |> Enum.chunk_by(fn x -> x == :map end)
      |> Enum.drop_every(2)
      |> dbg()

    {seeds, map_groups}
  end

  def parse_line(line) do
    case String.split(line, ~r/[: ]/) do
      ["seeds", "" | numbers] ->
        Enum.map(numbers, &String.to_integer/1)

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
