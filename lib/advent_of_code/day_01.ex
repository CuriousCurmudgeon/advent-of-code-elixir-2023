defmodule AdventOfCode.Day01 do
  @not_digits_regex ~r/[^0-9]/
  @letters_regex ~r/one|two|three|four|five|six|seven|eight|nine/
  @replace_map %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def part1(input) do
    String.split(input)
    |> Enum.reduce(0, &(calibrate(&1) + &2))
  end

  def part2(input) do
    String.split(input)
    |> Enum.reduce(0, &(fancy_calibrate(&1) + &2))
  end

  defp calibrate(input) do
    input
    |> String.replace(@not_digits_regex, "")
    |> then(fn x -> (String.first(x) <> String.last(x)) |> Integer.parse() end)
    |> elem(0)
  end

  defp fancy_calibrate(input) do
    input
    |> convert_to_digits()
    |> calibrate()
  end

  defp convert_to_digits(input, offset \\ 0) do
    case Regex.run(@letters_regex, input, offset: offset, return: :index) do
      [{index, length}] ->
        match = String.slice(input, index, length)
        replacement = Map.get(@replace_map, match)
        {a, b} = String.split_at(input, index + 1)
        convert_to_digits(a <> replacement <> b, index + 1)

      nil ->
        input
    end
  end
end
