defmodule Day2 do
  def solve_part_1(data) do
    data |> prepare |> checksum
  end

  def solve_part_2(data) do
    ids = data |> prepare

    for id <- ids do
      for id2 <- ids do
        compare(String.codepoints(id), String.codepoints(id2)) |> List.to_string()
      end
      |> Enum.filter(fn x -> String.length(x) == 25 end)
    end
    |> List.flatten()
    |> Enum.uniq()
  end

  defp prepare(data) do
    for line <- data do
      line
      |> String.trim()
    end
  end

  def compare([], []) do
    []
  end

  def compare(string1, string2) do
    [s1_head | s1_tail] = string1
    [s2_head | s2_tail] = string2

    match = if s1_head == s2_head, do: [s1_head], else: []
    match ++ compare(s1_tail, s2_tail)
  end

  @doc """
  Calculate a checksum from a collection of strings.

  ## Examples

      iex> Day2.checksum(~w(abcdef aabbcc aaabbbcc cccc ddd eee))
      6
  """
  def checksum(data) do
    counts =
      for text <- data do
        frequencies = occurrence_frequencies(text)

        {
          frequencies |> characters_with_frequency(2) |> length |> min(1),
          frequencies |> characters_with_frequency(3) |> length |> min(1)
        }
      end

    {twos, threes} = counts |> Enum.unzip()
    Enum.sum(twos) * Enum.sum(threes)
  end

  @doc """
  Return the number of characters occurring exactly `num` times. 

  ## Examples

      iex> Day2.characters_with_frequency(%{"a" => 1, "b" => 2, "c" => 1}, 1)
      ["a", "c"]
  """
  def characters_with_frequency(frequencies, num) do
    for {char, count} <- frequencies, count == num, do: char
  end

  @doc """
  Calculate character occurrence frequency for a string

  ## Examples

      iex> Day2.occurrence_frequencies("abcccb")
      %{"a" => 1, "b" => 2, "c" => 3}
  """
  def occurrence_frequencies(text) do
    String.codepoints(text)
    |> Enum.reduce(%{}, fn char, map ->
      Map.update(map, char, 1, &(&1 + 1))
    end)
  end
end
