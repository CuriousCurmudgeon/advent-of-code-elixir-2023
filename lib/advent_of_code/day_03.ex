defmodule AdventOfCode.Day03 do
  def part1(input) do
    {digits, symbols} =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.map(&parse_line/1)
      |> Enum.reduce({[], []}, fn {digits, symbols}, {digits_acc, symbols_acc} ->
        {digits ++ digits_acc, symbols ++ symbols_acc}
      end)

    symbols_mapset = MapSet.new(symbols)

    digits
    |> Enum.filter(&is_part_number(&1, symbols_mapset))
    |> Enum.map(fn {num, _} -> num end)
    |> Enum.sum()
  end

  def part2(_args) do
  end

  defp parse_line({line, index}) do
    digits =
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {start, length} ->
        {get_number_from_line(line, start, length), {index, start}}
      end)

    symbols =
      Regex.scan(~r/[^\d.]/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {start, _} -> {index, start} end)

    {digits, symbols}
  end

  defp get_number_from_line(line, start, length) do
    String.slice(line, start, length) |> String.to_integer()
  end

  defp is_part_number({num, {line, index}}, symbols_mapset) do
    num_length = num |> Integer.digits() |> length()

    (line - 1)..(line + 1)
    |> Enum.any?(&line_matches(&1, index, num_length, symbols_mapset))
  end

  defp line_matches(line, index, num_length, symbols_mapset) do
    (index - 1)..(index + num_length)
    |> Enum.any?(fn i -> MapSet.member?(symbols_mapset, {line, i}) end)
  end
end
