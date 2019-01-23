defmodule Boggle.Board do
  @dimension 4

  @dice [
    ~w[r i f o b x],
    ~w[i f e h e y],
    ~w[d e n o w s],
    ~w[u t o k n d],
    ~w[h m s r a o],
    ~w[l u p e t s],
    ~w[a c i t o a],
    ~w[y l g k u e],
    ~w[qu b m j o a],
    ~w[e h i s p n],
    ~w[v e t i g n],
    ~w[b a l i y t],
    ~w[e z a v n d],
    ~w[r a l e s c],
    ~w[u w i l r g],
    ~w[p a c e m d]
  ]

  @doc """
  Rolls the dice, generating a randomized board.
  """
  def random_board() do
    {_, board} =
      Enum.shuffle(@dice)
      |> Enum.reduce({0, %{}}, fn die, {index, board} ->
        {row, col} = {div(index, @dimension), rem(index, @dimension)}
        {index + 1, Map.put(board, {row, col}, Enum.random(die))}
      end)

    board
  end

  def dimension(), do: @dimension
end
