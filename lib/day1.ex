defmodule Day1 do
  @doc ~S"""
  Convert a collection of strings into integers and sum them. 

  ## Examples

      iex> Day1.solve_part_1(["1\n", "-2\n","3"])
      2

  """
  def solve_part_1(data) do
    data |> prepare |> Enum.sum()
  end

  @doc ~S"""
  Find first repeating sum

  ## Examples

      iex> Day1.solve_part_2(["1\n", "-1\n"])
      0

      iex> Day1.solve_part_2(~w(+3 +3 -3))
      3

      iex> Day1.solve_part_2(~w(+3 +3 +4 -2 -4))
      10
  """
  def solve_part_2(data) do
    nums = data |> prepare
    find_repeat(nums, nums, 0, MapSet.new([0]))
  end

  defp prepare(data) do
    for line <- data do
      line
      |> String.trim()
      |> String.to_integer()
    end
  end

  defp find_repeat([], data, sum, memo) do
    find_repeat(data, data, sum, memo)
  end

  defp find_repeat([head | tail], data, sum, memo) do
    current = sum + head

    if MapSet.member?(memo, current) do
      current
    else
      find_repeat(tail, data, current, MapSet.put(memo, current))
    end
  end
end
