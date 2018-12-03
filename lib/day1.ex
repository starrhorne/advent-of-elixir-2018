defmodule Day1 do
  @doc ~S"""
  Convert a collection of strings into integers and sum them. 

  ## Examples

      iex> Day1.solve_part_1(["1\n", "-2\n","3"])
      2

  """
  def solve_part_1(data) do
    data |> prepare |> transform
  end

  defp prepare(data) do
    for line <- data do
      line
      |> String.trim()
      |> String.to_integer()
    end
  end

  defp transform(data) do
    data |> Enum.sum()
  end
end
