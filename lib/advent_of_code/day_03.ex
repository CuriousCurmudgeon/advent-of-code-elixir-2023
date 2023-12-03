defmodule AdventOfCode.Day03 do
  ##########
  # Part 1 #
  ##########
  def part1(input) do
    {digits, symbols} =
      input
      |> prep_input()
      |> Enum.map(&parse_part1_line/1)
      |> Enum.reduce({[], []}, fn {digits, symbols}, {digits_acc, symbols_acc} ->
        {digits ++ digits_acc, symbols ++ symbols_acc}
      end)

    symbols_mapset = MapSet.new(symbols)

    digits
    |> Enum.filter(&is_part_number(&1, symbols_mapset))
    |> Enum.map(fn {num, _} -> num end)
    |> Enum.sum()
  end

  defp parse_part1_line({line, index}) do
    {parse_digits(line, index), parse_symbols(line, index)}
  end

  defp parse_symbols(line, index) do
    Regex.scan(~r/[^\d.]/, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {start, _} -> {index, start} end)
  end

  defp is_part_number({num, {line, index}}, symbols_mapset) do
    num_length = num_length(num)

    (line - 1)..(line + 1)
    |> Enum.any?(&line_matches(&1, index, num_length, symbols_mapset))
  end

  ##########
  # Part 2 #
  ##########
  def part2(input) do
    {digits, stars} =
      input
      |> prep_input()
      |> Enum.map(&parse_part2_line/1)
      |> Enum.reduce({[], []}, fn {digits, stars}, {digits_acc, stars_acc} ->
        {digits ++ digits_acc, stars ++ stars_acc}
      end)

    digits_map =
      digits
      |> Enum.reduce(%{}, fn {digit, {line, index}}, acc ->
        index..(index + num_length(digit) - 1)
        |> Enum.reduce(%{}, fn i, a -> Map.put(a, {line, i}, digit) end)
        |> Map.merge(acc)
      end)
  end

  defp parse_part2_line({line, index}) do
    {parse_digits(line, index), parse_stars(line, index)}
  end

  defp parse_stars(line, index) do
    Regex.scan(~r/\*/, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {start, _} -> {index, start} end)
  end

  defp is_gear({num, {line, index}}, gears_mapset) do
  end

  ##########
  # Shared #
  ##########
  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
  end

  defp parse_digits(line, index) do
    Regex.scan(~r/\d+/, line, return: :index)
    |> List.flatten()
    |> Enum.map(fn {start, length} ->
      {get_number_from_line(line, start, length), {index, start}}
    end)
  end

  defp get_number_from_line(line, start, length) do
    String.slice(line, start, length) |> String.to_integer()
  end

  defp line_matches(line, index, num_length, symbols_mapset) do
    (index - 1)..(index + num_length)
    |> Enum.any?(fn i -> MapSet.member?(symbols_mapset, {line, i}) end)
  end

  defp num_length(num) do
    num |> Integer.digits() |> length()
  end
end
