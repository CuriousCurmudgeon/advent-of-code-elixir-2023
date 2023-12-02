defmodule AdventOfCode.Day02 do
  def part1(input) do
    input
    |> parse_games()
    |> Enum.filter(&valid_game?/1)
    |> Enum.map(fn {game_id, _} -> game_id end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_games()
    |> Enum.map(&min_cubes/1)
    |> Enum.map(fn min_cubes -> Map.values(min_cubes) |> Enum.reduce(fn x, acc -> x * acc end) end)
    |> Enum.sum()
  end

  defp parse_games(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
  end

  defp parse_game(input) do
    [game_string | handful_strings] = String.split(input, [":", ";"])
    game_id = game_string |> String.split() |> List.last() |> Integer.parse() |> elem(0)

    handfuls =
      handful_strings
      |> Enum.map(fn h -> Regex.scan(~r/\d+\s[a-z]+/, h) |> List.flatten() end)
      |> Enum.map(&parse_colors/1)

    {game_id, handfuls}
  end

  defp parse_colors(color_string_list) do
    color_string_list
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn x, map ->
      {color, count} = parse_color(x)
      Map.put(map, color, count)
    end)
  end

  defp parse_color(color_string) do
    [count_string, color] = String.split(color_string)
    {String.to_atom(color), Integer.parse(count_string) |> elem(0)}
  end

  defp valid_game?({_, handfuls}) do
    handfuls
    |> Enum.all?(fn x -> x.red <= 12 and x.green <= 13 and x.blue <= 14 end)
  end

  defp min_cubes({_, handfuls}) do
    handfuls
    |> Enum.reduce(fn x, map ->
      %{
        red: Kernel.max(x.red, map.red),
        green: Kernel.max(x.green, map.green),
        blue: Kernel.max(x.blue, map.blue)
      }
    end)
  end
end
