defmodule Mix.Tasks.D02.P2 do
  use Mix.Task

  import AdventOfCode.Day02

  @shortdoc "Day 02 Part 2"
  def run(args) do
    input = """
    Game 1: 5 red, 1 green, 2 blue; 2 green, 8 blue, 6 red; 8 red, 3 blue, 2 green; 6 red, 1 green, 19 blue; 1 red, 17 blue
    Game 2: 4 red, 5 green, 2 blue; 7 red, 14 green, 3 blue; 2 green, 5 blue, 11 red; 10 blue, 3 green; 9 green, 6 blue, 13 red; 7 red, 5 green, 9 blue
    Game 3: 9 green, 18 blue, 1 red; 6 red, 10 blue, 5 green; 4 blue, 4 red, 15 green
    Game 4: 1 red, 13 green; 10 green, 2 red; 3 red, 4 green, 2 blue
    Game 5: 4 red, 2 green, 1 blue; 4 red, 9 blue; 4 green, 1 red, 6 blue; 3 blue, 2 green, 6 red; 5 red, 4 green, 1 blue
    Game 6: 6 red, 3 green, 6 blue; 3 green, 5 blue, 12 red; 3 green, 9 blue, 3 red; 13 red, 8 blue
    Game 7: 3 blue, 1 red; 3 blue, 10 green; 4 green, 5 blue
    Game 8: 11 green, 4 blue; 4 red, 4 blue, 11 green; 4 green, 3 blue; 1 blue, 6 red, 12 green
    Game 9: 1 blue, 4 green, 1 red; 5 green, 3 blue; 9 green, 4 blue; 3 blue, 1 red, 10 green; 6 green, 2 blue
    Game 10: 5 green, 6 red, 7 blue; 7 green, 5 blue, 5 red; 8 red, 6 blue, 8 green; 2 blue, 8 green, 6 red; 6 blue, 8 red, 4 green
    Game 11: 1 blue, 10 red, 10 green; 11 green, 2 blue, 16 red; 4 blue, 7 red, 14 green
    Game 12: 8 green, 9 red, 12 blue; 2 green, 4 blue, 7 red; 1 red, 9 blue, 7 green; 8 green, 2 red, 10 blue; 1 green, 5 red, 5 blue; 6 green, 5 red, 1 blue
    Game 13: 3 green, 1 blue, 6 red; 1 green, 10 red; 1 blue, 15 red, 2 green
    Game 14: 2 green, 6 blue; 1 green, 2 blue, 2 red; 5 blue, 1 green, 2 red; 4 green, 5 blue, 4 red; 4 red, 5 green, 4 blue; 1 red, 5 green, 6 blue
    Game 15: 12 green, 7 blue; 19 green; 11 blue, 16 green, 1 red; 1 red, 2 green, 3 blue; 8 blue, 1 red, 19 green; 14 blue, 3 green, 1 red
    Game 16: 2 green, 13 blue, 3 red; 5 red, 12 blue; 6 blue, 8 red; 4 red, 1 green, 4 blue; 1 green, 15 blue; 4 blue, 2 green, 1 red
    Game 17: 11 blue, 7 green, 2 red; 12 red, 8 green, 8 blue; 2 red, 6 blue, 6 green
    Game 18: 1 green, 2 blue; 2 green, 1 blue, 4 red; 3 green, 16 red; 2 red, 3 green
    Game 19: 11 blue, 3 green, 3 red; 11 blue, 5 green; 3 green, 3 red, 8 blue
    Game 20: 1 green, 6 blue; 4 blue, 6 green; 1 red, 10 green; 12 green; 5 blue, 1 red, 4 green; 1 green, 5 blue
    Game 21: 7 green, 3 blue; 1 red, 5 blue, 6 green; 1 red, 11 green; 8 blue, 1 red, 10 green; 1 red, 5 blue, 3 green
    Game 22: 3 red, 1 blue; 3 green, 1 red, 1 blue; 7 green, 2 blue
    Game 23: 12 green, 1 red, 2 blue; 10 blue, 1 green, 1 red; 9 blue, 8 green
    Game 24: 5 blue, 6 green, 6 red; 3 blue, 1 red; 8 blue, 2 green, 12 red; 1 green, 2 blue, 14 red; 2 blue, 5 green, 15 red
    Game 25: 6 red, 13 green; 1 blue, 1 red, 3 green; 1 blue, 12 red, 10 green
    Game 26: 16 red, 2 blue, 7 green; 1 blue, 7 green, 8 red; 1 blue, 3 red, 9 green
    Game 27: 4 blue, 15 green; 6 green, 2 blue, 1 red; 9 blue, 10 green, 4 red; 3 red, 3 green, 6 blue; 11 blue, 7 red, 11 green; 6 red, 5 green, 13 blue
    Game 28: 10 blue, 8 red, 10 green; 4 blue, 11 red, 6 green; 8 red, 9 green, 10 blue; 4 red, 9 green, 2 blue
    Game 29: 4 red, 9 green, 7 blue; 10 blue, 6 green, 4 red; 1 green, 2 red, 10 blue; 3 green, 9 blue
    Game 30: 6 blue, 9 green, 10 red; 6 blue, 4 red; 5 green, 2 blue; 5 green, 2 red, 2 blue; 6 blue, 8 green
    Game 31: 7 blue; 2 green, 6 blue; 1 red, 9 blue, 5 green
    Game 32: 8 blue, 2 red, 4 green; 6 red, 2 blue, 1 green; 14 blue, 8 green, 8 red
    Game 33: 1 green, 1 red, 1 blue; 2 blue, 1 green, 12 red; 1 green, 1 red; 1 blue, 2 red, 1 green; 7 red, 2 green, 2 blue
    Game 34: 3 blue; 2 blue; 10 red, 1 blue, 1 green; 5 red; 1 green, 1 red, 1 blue; 1 green, 2 red
    Game 35: 10 green, 1 red, 16 blue; 4 red, 10 blue, 9 green; 1 green, 7 blue, 5 red
    Game 36: 1 blue, 3 red, 16 green; 1 blue, 3 red, 1 green; 9 green, 3 red, 8 blue; 14 green, 6 blue, 3 red; 3 red, 12 green, 4 blue
    Game 37: 11 red, 3 blue; 15 red, 8 blue, 6 green; 6 green, 19 red, 11 blue; 1 green, 4 blue, 14 red; 12 blue, 5 red, 8 green; 4 blue, 9 red
    Game 38: 4 green, 10 blue, 3 red; 1 green, 1 red, 11 blue; 2 red, 12 blue
    Game 39: 3 green, 1 red, 4 blue; 9 green, 1 red, 18 blue; 4 red, 4 green, 17 blue; 4 red, 10 blue, 14 green
    Game 40: 5 red, 4 green, 8 blue; 1 green, 9 blue; 9 blue, 3 red, 6 green; 8 red, 9 blue, 9 green
    Game 41: 1 blue, 9 red, 3 green; 9 red, 10 green, 15 blue; 13 red, 8 green, 8 blue; 19 red, 6 blue, 2 green; 7 green, 5 blue, 12 red
    Game 42: 15 blue; 1 red, 1 green, 9 blue; 6 blue, 1 red; 1 green, 4 blue
    Game 43: 1 green, 8 blue, 2 red; 1 red, 1 green, 6 blue; 7 blue; 7 blue, 3 red, 1 green; 2 red, 5 blue
    Game 44: 7 green, 11 blue, 6 red; 9 green, 8 blue; 4 red, 15 green; 12 green, 14 blue, 8 red
    Game 45: 4 red, 4 green; 14 green; 4 green, 2 blue; 1 blue, 12 red, 5 green; 3 red, 6 green; 11 red, 1 green
    Game 46: 2 blue, 1 green, 1 red; 1 blue, 6 green, 1 red; 2 blue, 1 red, 1 green; 5 green
    Game 47: 1 blue, 1 red; 14 red; 3 green, 2 blue, 17 red; 4 green
    Game 48: 1 red, 11 green, 2 blue; 1 red, 11 green, 6 blue; 13 green, 1 blue, 3 red; 3 green, 4 red, 6 blue; 12 green, 5 blue, 1 red; 2 red, 4 green, 4 blue
    Game 49: 5 blue, 3 green; 2 green, 8 blue; 5 blue; 4 green, 5 blue, 1 red; 4 green, 7 blue; 1 green, 3 blue
    Game 50: 3 red, 5 green, 2 blue; 9 green, 7 red, 4 blue; 3 blue, 6 red, 13 green; 6 blue, 8 red, 9 green
    Game 51: 2 green, 11 red, 7 blue; 5 blue, 13 red; 1 green, 2 blue, 3 red; 6 blue, 8 red; 11 red, 2 green, 4 blue
    Game 52: 15 blue, 1 green, 4 red; 4 green, 10 blue, 2 red; 6 red, 18 blue, 1 green
    Game 53: 2 red, 10 green, 6 blue; 4 green, 3 blue, 3 red; 17 blue, 19 green, 5 red; 6 blue, 6 green, 9 red; 5 blue, 17 green, 7 red
    Game 54: 9 blue, 8 red, 6 green; 6 red, 8 green; 1 green, 6 blue, 1 red; 5 red, 4 green, 9 blue; 5 blue, 2 green, 5 red
    Game 55: 8 blue, 8 red, 10 green; 3 red, 4 green, 9 blue; 4 red, 3 green, 7 blue
    Game 56: 3 red, 6 green, 1 blue; 5 green, 1 blue, 1 red; 1 red, 2 green; 10 green
    Game 57: 1 green, 4 blue, 12 red; 17 red, 7 blue, 10 green; 17 red, 5 blue, 3 green
    Game 58: 1 red, 5 green, 14 blue; 5 green, 6 red, 7 blue; 4 blue, 8 green; 3 red, 9 green, 7 blue; 8 blue, 8 green, 6 red; 8 green, 7 blue, 5 red
    Game 59: 3 green, 5 red; 2 red, 13 green, 1 blue; 19 green, 1 red, 1 blue; 19 green, 1 blue; 18 green, 1 blue, 5 red; 6 red, 9 green
    Game 60: 5 red, 1 green, 6 blue; 8 red, 6 blue, 14 green; 8 green, 8 red, 3 blue; 2 blue, 5 green, 3 red; 4 blue, 1 red, 14 green
    Game 61: 7 red, 4 blue, 2 green; 2 green, 8 red, 9 blue; 5 blue, 2 green, 8 red; 8 red, 1 green, 8 blue
    Game 62: 6 red, 3 blue; 1 blue, 2 red, 2 green; 3 red, 1 blue
    Game 63: 2 red, 1 blue, 2 green; 1 blue, 1 green; 2 green, 4 red; 3 green, 2 red; 2 green
    Game 64: 5 green, 6 blue, 7 red; 2 red, 5 green, 8 blue; 7 green, 9 blue, 1 red; 4 green, 5 blue; 19 blue, 5 green, 13 red
    Game 65: 3 red, 1 blue, 4 green; 5 green, 3 blue; 9 green, 1 red, 10 blue
    Game 66: 6 red, 13 green, 2 blue; 2 blue, 5 red, 9 green; 18 red; 2 green, 1 blue, 1 red; 19 red, 10 green; 1 blue, 15 green, 13 red
    Game 67: 8 blue, 3 red; 1 red, 12 green, 7 blue; 4 red, 6 blue, 5 green; 11 green, 10 blue, 7 red; 5 red, 9 green, 14 blue
    Game 68: 1 red, 3 green; 10 blue, 1 red, 3 green; 1 green, 17 blue; 16 blue; 6 blue
    Game 69: 11 green, 5 blue, 8 red; 2 red, 5 green, 1 blue; 10 green, 2 blue; 11 green, 7 red, 4 blue
    Game 70: 2 green, 1 blue, 13 red; 16 green, 20 red, 4 blue; 10 red
    Game 71: 10 blue, 6 green, 7 red; 5 red, 5 green, 2 blue; 7 green, 4 red, 5 blue; 1 red, 8 blue; 5 red, 1 blue, 8 green; 5 blue, 1 red, 5 green
    Game 72: 2 red, 4 green; 2 green, 2 red, 1 blue; 3 blue, 3 green, 2 red; 2 green
    Game 73: 5 red, 19 blue; 12 blue, 4 green, 16 red; 14 red, 11 blue, 1 green
    Game 74: 2 red, 1 green, 9 blue; 5 blue, 1 green, 2 red; 2 green, 1 red, 13 blue; 2 green, 1 red, 3 blue
    Game 75: 7 blue, 1 red, 18 green; 17 green, 8 red, 13 blue; 15 blue, 4 red
    Game 76: 1 green, 12 red, 13 blue; 5 green, 11 blue, 12 red; 10 red, 1 green; 10 red, 2 blue; 5 red, 2 green; 2 green, 17 blue, 3 red
    Game 77: 2 blue, 1 red, 1 green; 7 red; 7 red, 3 blue, 2 green; 10 green, 1 red; 3 red, 7 blue, 6 green
    Game 78: 10 red, 2 blue, 2 green; 1 blue, 6 red, 4 green; 12 red, 8 green; 6 green, 8 red, 7 blue; 11 green, 5 blue, 6 red
    Game 79: 7 green, 5 red; 6 blue, 2 green, 15 red; 9 blue, 2 red, 12 green; 1 blue, 4 red, 10 green; 4 blue, 12 green, 11 red; 5 green, 3 red, 5 blue
    Game 80: 1 green, 13 blue, 2 red; 2 red, 1 green, 13 blue; 7 blue, 8 red
    Game 81: 1 green, 2 red, 11 blue; 5 red, 3 blue; 1 green, 1 red; 14 red, 1 green
    Game 82: 12 red, 3 blue, 8 green; 15 red, 9 blue, 8 green; 6 blue, 13 red, 8 green
    Game 83: 4 blue, 6 green, 3 red; 7 red, 2 blue, 9 green; 6 green, 3 red
    Game 84: 4 green; 3 red, 3 blue; 4 red, 1 blue, 2 green; 1 red, 5 green, 5 blue; 1 red, 5 blue, 3 green
    Game 85: 3 red, 4 blue, 15 green; 9 green; 2 red, 4 blue, 6 green; 1 red, 4 green, 7 blue; 3 red, 10 green, 9 blue; 1 red, 13 green, 3 blue
    Game 86: 8 red, 6 blue; 3 blue, 3 green, 15 red; 12 red, 6 green, 13 blue; 15 red, 6 green, 10 blue
    Game 87: 4 red, 4 blue; 6 red, 2 blue; 5 blue, 3 green; 4 blue, 2 red
    Game 88: 4 blue, 7 green; 2 blue, 7 green; 6 green, 4 blue; 1 red, 1 blue, 2 green; 11 green, 3 blue
    Game 89: 1 blue, 12 green, 11 red; 3 red, 7 blue, 1 green; 7 green, 8 red; 6 blue, 2 green, 3 red; 7 red, 8 green; 11 blue, 5 red, 12 green
    Game 90: 1 green, 12 red, 17 blue; 14 red, 17 blue, 9 green; 6 green, 9 red, 11 blue
    Game 91: 3 green, 14 blue; 2 blue, 2 green, 6 red; 1 red, 11 blue, 1 green; 3 green, 4 red, 20 blue; 6 red, 2 green, 3 blue; 10 blue, 12 red
    Game 92: 6 blue, 7 red; 2 blue, 4 red, 1 green; 4 red, 1 green, 3 blue; 2 red, 5 blue; 8 red, 6 blue; 1 green, 2 blue, 1 red
    Game 93: 4 blue, 1 green, 4 red; 8 red, 4 green, 4 blue; 2 blue, 9 red; 1 blue, 4 red; 4 blue, 2 green, 11 red
    Game 94: 5 blue, 1 green, 7 red; 1 green, 11 blue, 1 red; 1 green, 15 blue, 4 red
    Game 95: 1 red, 3 blue; 1 red, 1 green, 8 blue; 3 red, 1 green, 3 blue; 3 red, 6 blue; 6 blue
    Game 96: 4 green, 1 blue; 7 green, 3 red; 2 blue, 9 red, 16 green; 3 blue, 4 red, 11 green
    Game 97: 6 green, 8 blue; 1 blue, 1 green; 3 green, 4 blue; 8 blue, 5 green, 2 red
    Game 98: 18 blue, 6 green; 11 green, 3 blue, 7 red; 18 blue, 3 red, 7 green; 5 red, 5 green; 8 blue, 2 green, 11 red
    Game 99: 3 red, 2 green, 3 blue; 1 red, 4 green, 1 blue; 2 green, 18 red; 15 red, 1 blue; 2 blue, 9 red, 2 green; 17 red, 3 blue, 4 green
    Game 100: 9 blue, 8 red, 16 green; 3 red, 7 green, 8 blue; 1 green, 3 red, 12 blue; 3 green, 14 blue
    """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
