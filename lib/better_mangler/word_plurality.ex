defmodule BetterMangler.WordPlurality do
  @moduledoc """

  """

  alias Inflex
  alias Verbs

  @doc """

  """
  def handle_list(worded_list) do
    Enum.map(worded_list, &handle_map/1)
  end

  defp handle_map(%{part_of_speech: "noun", plurality: "plural", word: word}) do
    Inflex.pluralize(word)
  end

  defp handle_map(%{part_of_speech: "verb", plurality: "singular", tense: "present", word: word} = map) do
    Verbs.conjugate(word, tense: map.tense, plurality: map.plurality, person: "third")
  end

  defp handle_map(%{word: word}) do
    word
  end
end
