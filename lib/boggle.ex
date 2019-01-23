defmodule Boggle do
  @moduledoc """
  A solution for a 4x4 Boggle game.
  """

  alias Boggle.{Board, Dictionary}

  defp neighbors(board, {x, y}) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1}
    ]
    |> Enum.filter(&Map.has_key?(board, &1))
  end

  defp empty_list?([]), do: true
  defp empty_list?([_]), do: false
  defp empty_list?([_ | _]), do: false

  defp continue?(dict, prefix) do
    Retrieval.prefix(dict, prefix)
    |> empty_list?
    |> Kernel.!()
  end

  defp self_match(_dict, word) when byte_size(word) < 4, do: []

  defp self_match(dict, word) do
    case Retrieval.contains?(dict, word) do
      true -> [word]
      false -> []
    end
  end

  def play() do
    dict = Dictionary.as_trie()
    board = Board.random_board()

    dim = Board.dimension()

    for x <- 0..(dim - 1), y <- 0..(dim - 1) do
      solve(dict, board, "", {x, y})
    end
    |> List.flatten()
  end

  @doc """
  Finds all words of length 4 or greater on a grid, given
  a starting location to search.

  ## Examples
  iex> Boggle.solve(Boggle.Dictionary.as_trie(),
  ...>   %{{0, 0} => "a", {0, 1} => "p", {0, 2} => "p", {0, 3} => "l",
  ...>   {1, 3} => "e", {2, 3} => "s", {3, 3} => "a", {3, 2} => "u",
  ...>   {2, 2} => "c", {2, 1} => "e" },
  ...>   "", {0, 0})
  [ "apple", "apples", "applesauce" ]
  """
  def solve(dict, board, word, point) do
    word = word <> Map.get(board, point)
    board = Map.delete(board, point)
    base = self_match(dict, word)

    neighbors(board, point)
    |> Enum.reduce(base, fn neighbor, acc ->
      case continue?(dict, word) do
        true -> [acc | solve(dict, board, word, neighbor)]
        false -> acc
      end
    end)
    |> List.flatten()
  end
end
