defmodule BetterMangler.WordPlurality do
  @moduledoc """

  """

  alias Inflex
  alias Verbs

  @doc """

  """
  def handle_list(worded_list) when is_list(worded_list) do
    Enum.map(worded_list, &handle_map/1)
  end

  def handle_list({ :error, _ } = error) do
    error
  end

  defp handle_map(%{part_of_speech: "noun", plurality: "plural"} = map) do
    Inflex.pluralize(map.word)
  end

  defp handle_map(%{part_of_speech: "verb", plurality: "singular", tense: "present"} = map) do
    Verbs.conjugate(map.word, tense: "present", plurality: "singular", person: "third")
  end

  defp handle_map(map) do
    map.word
  end
end
