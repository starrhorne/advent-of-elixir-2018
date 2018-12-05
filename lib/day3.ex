defmodule Square do
  defstruct id: nil, x: nil, y: nil, w: nil, h: nil
end

defmodule Day3 do
  @doc ~S"""
  Given a list of squares, return the number of square inches with overlaps.

  ## Examples

      iex> Day3.solve_part_1(["#1 @ 1,3: 4x4\n", "#2 @ 3,1: 4x4\n", "#3 @ 5,5: 2x2\n"])
      4
  """
  def solve_part_1(data) do
    data
    |> prepare
    |> Enum.reduce(%{}, &plot/2)
    |> Enum.count(fn {_, ids} -> length(ids) > 1 end)
  end

  @doc ~S"""
  Given a list of squares, find the squares with no overlaps

  ## Examples

      iex> Day3.solve_part_2(["#1 @ 1,3: 4x4\n", "#2 @ 3,1: 4x4\n", "#3 @ 5,5: 2x2\n"])
      [3]
  """
  def solve_part_2(data) do
    data
    |> prepare
    |> Enum.reduce(%{}, &plot/2)
    |> Enum.reduce(%{}, &count_overlaps/2)
    |> Enum.filter(fn {_id, overlaps} -> overlaps == 1 end)
    |> Enum.map(fn {id, _overlaps} -> id end)
  end

  def prepare(data) do
    for line <- data do
      line
      |> String.trim()
      |> parse
    end
  end

  @doc """
  Parse a line like
    #99 @ 1,3: 4x4

  ## Examples

      iex> Day3.parse("#99 @ 100,3: 4x40")
      %Square{id: 99, x: 100, y: 3, w: 4, h: 40}
  """
  def parse(line) do
    [id, x, y, w, h] =
      ~r/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/
      |> Regex.run(line)
      |> Enum.slice(1..5)
      |> Enum.map(&String.to_integer/1)

    %Square{id: id, x: x, y: y, w: w, h: h}
  end

  @doc """
  Apply a square to the map, which is a grid showing the 
  claimants of every square inch

  ## Examples

      iex> x = Day3.plot(%Square{id: 99, x: 3, y: 2, w: 3, h: 2}, %{})
      iex> Day3.plot(%Square{id: 2, x: 3, y: 2, w: 1, h: 2}, x)
      %{{3,2} => [99,2], {4,2} => [99], {5,2} => [99], {3,3} => [99, 2], {4,3} => [99], {5,3} => [99]}
  """
  def plot(square, map) do
    square
    |> cells
    |> Enum.reduce(map, fn point, acc ->
      Map.update(acc, point, [square.id], &(&1 ++ [square.id]))
    end)
  end

  def count_overlaps({_position, ids}, map) do
    Enum.reduce(ids, map, fn id, acc ->
      Map.update(acc, id, 1, &max(&1, length(ids)))
    end)
  end

  defp cells(square) do
    for dx <- 0..(square.w - 1), dy <- 0..(square.h - 1) do
      {square.x + dx, square.y + dy}
    end
  end
end
