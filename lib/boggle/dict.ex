defmodule Boggle.Dictionary do
  def as_trie() do
    File.stream!("/usr/share/dict/words")
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(Retrieval.new, fn(word, trie) ->
      Retrieval.insert(trie, word)
    end)
  end
end
