defmodule AdventOfCode.Day03 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(&parse_line/1)
    |> dbg()
  end

  def part2(_args) do
  end

  # Returns a list of lists of the form
  # [[{-1, 0}, {5, 1}], [{7, 2}, {-1, 0}]]
  # See docs for Regex.scan/3 for details
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
end
