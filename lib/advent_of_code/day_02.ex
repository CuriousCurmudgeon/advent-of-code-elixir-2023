defmodule AdventOfCode.Day02 do
  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
    |> Enum.filter(fn x -> x end)
    |> dbg()
  end

  def part2(_args) do
  end

  defp parse_game(""), do: nil

  defp parse_game(input) do
    [game_string | handful_strings] = String.split(input, [":", ";"])
    game_id = game_string |> String.split() |> List.last() |> Integer.parse() |> elem(0)

    handfuls =
      handful_strings
      |> Enum.map(fn h -> Regex.scan(~r/\d\s[a-z]+/, h) |> List.flatten() end)
      |> Enum.map(&parse_colors/1)

    {game_id, handfuls}
  end

  defp parse_colors(color_string_list) do
    color_string_list
    |> Enum.reduce(%{}, fn x, map ->
      {color, count} = parse_color(x)
      Map.put(map, color, count)
    end)
  end

  defp parse_color(color_string) do
    [count_string, color] = String.split(color_string)
    {String.to_atom(color), Integer.parse(count_string) |> elem(0)}
  end
end
