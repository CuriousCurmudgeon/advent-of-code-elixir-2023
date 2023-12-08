defmodule AdventOfCode.Day05 do
  def part1(input) do
    [seed_line | rest] = prep_input(input)

    parse_part1_seed_line(seed_line)
    |> solve(rest)
  end

  defp parse_part1_seed_line(line) do
    ["seeds", "" | numbers] = String.split(line, ~r/[: ]/)
    Enum.map(numbers, &String.to_integer/1)
  end

  def find_location(seed, mappings) do
    mappings
    |> Enum.reduce(seed, fn mapping, cur_dest ->
      get_destination_number(mapping, cur_dest)
    end)
  end

  def get_destination_number(mapping, seed) do
    case Enum.find(mapping, fn {_dest, source, range} ->
           seed >= source and seed < source + range
         end) do
      nil -> seed
      {dest, source, _range} -> seed + (dest - source)
    end
  end

  def part2(_args) do
  end

  ##########
  # Shared #
  ##########
  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  defp parse_line(line) do
    case String.split(line, ~r/[: ]/) do
      [""] ->
        nil

      [_, "map" | _] ->
        :map

      [_, _, _] = mapping ->
        [dest, source, range] = Enum.map(mapping, &String.to_integer/1)
        {dest, source, range}
    end
  end

  defp solve(seeds, lines) do
    map_lines =
      lines
      |> Enum.map(&parse_line/1)
      |> Enum.filter(& &1)

    mappings =
      map_lines
      |> Enum.chunk_by(fn x -> x == :map end)
      |> Enum.drop_every(2)

    seeds
    |> Enum.map(&find_location(&1, mappings))
    |> Enum.min()
  end
end
