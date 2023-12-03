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
    # Check on line above at all character positions from index - 1 to index + 1
    symbol_above =
      (index - 1)..(index + num_length)
      |> Enum.any?(fn i -> MapSet.member?(symbols_mapset, {line - 1, i}) end)

    # Check index - 1 and index + 1 on current line
    symbol_next_to =
      MapSet.member?(symbols_mapset, {line, index - 1}) ||
        MapSet.member?(symbols_mapset, {line, index + num_length})

    # Check on line above at all character positions from index - 1 to index + 1
    symbol_below =
      (index - 1)..(index + num_length)
      |> Enum.any?(fn i -> MapSet.member?(symbols_mapset, {line + 1, i}) end)

    symbol_above or symbol_next_to or symbol_below
  end
end
