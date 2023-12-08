defmodule AdventOfCode.Day05 do
  ##########
  # Part 1 #
  ##########
  def part1(input) do
    [seed_line | rest] = prep_input(input)
    seeds = parse_part1_seed_line(seed_line)
    mappings = parse_mappings(rest)

    seeds
    |> Enum.map(&part1_find_location(&1, mappings))
    |> Enum.min()
  end

  defp parse_part1_seed_line(line) do
    ["seeds", "" | numbers] = String.split(line, ~r/[: ]/)
    Enum.map(numbers, &String.to_integer/1)
  end

  def part1_find_location(seed, mappings) do
    mappings
    |> Enum.reduce(seed, fn mapping, cur_dest ->
      part1_get_destination_number(mapping, cur_dest)
    end)
  end

  def part1_get_destination_number(mapping, seed) do
    case Enum.find(mapping, fn {_dest, source, range} ->
           seed >= source and seed < source + range
         end) do
      nil -> seed
      {dest, source, _range} -> seed + (dest - source)
    end
  end

  ##########
  # Part 2 #
  ##########
  def part2(input) do
    [seed_line | rest] = prep_input(input)
    seed_ranges = parse_part2_seed_line(seed_line) |> IO.inspect()
    mappings = parse_mappings(rest)
  end

  defp parse_part2_seed_line(line) do
    ["seeds", "" | numbers] = String.split(line, ~r/[: ]/)

    seeds =
      numbers
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.map(fn [start, range] -> start..(start + range - 1) end)

    seeds
  end

  ##########
  # Shared #
  ##########
  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  defp parse_mappings(lines) do
    lines
    |> Enum.map(&parse_line/1)
    |> Enum.filter(& &1)
    |> Enum.chunk_by(fn x -> x == :map end)
    |> Enum.drop_every(2)
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
end
