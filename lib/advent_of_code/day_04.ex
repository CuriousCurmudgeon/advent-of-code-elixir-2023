defmodule AdventOfCode.Day04 do
  ##########
  # Part 1 #
  ##########
  def part1(input) do
    input
    |> prep_input()
    |> Enum.map(fn x ->
      [_, numbers] = String.split(x, ":")
      numbers
    end)
    |> Enum.map(&count_winners/1)
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.reduce(0, fn x, acc -> :math.pow(2, x - 1) + acc end)
  end

  defp count_winners(card) do
    [winners, mine] =
      card
      |> String.split("|")
      |> Enum.map(&String.split/1)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(winners, mine)
    |> MapSet.size()
  end

  ##########
  # Part 2 #
  ##########
  def part2(input) do
    cards =
      input
      |> prep_input()
      |> to_map()

    # Now process a line. Take the number of matching numbers, look up the game in
    # the map, and update the number of copies of that card in the tuple by
    count_cards(1, cards, 0)
  end

  defp to_map(lines) do
    # Turn the list of lines into a map keyed by game id.
    # Each value is a tuple containing the list and how many times to process it
    Enum.reduce(lines, %{}, fn line, acc ->
      [label, numbers] = String.split(line, ":")
      [_, card_id] = String.split(label)
      Map.put_new(acc, String.to_integer(card_id), {1, numbers})
    end)
  end

  defp count_cards(i, cards, total) when map_size(cards) == 0 do
    total
  end

  defp count_cards(i, cards, total) do
    Map.get(cards, i)
    |> elem(1)
    |> count_winners()
    |> dbg()
  end

  ##########
  # Shared #
  ##########
  defp prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end
end
