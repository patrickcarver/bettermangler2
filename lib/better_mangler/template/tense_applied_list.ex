defmodule BetterMangler.Template.TenseAppliedList do
  @moduledoc """

  """

  @doc """
    
  """
  def generate(lettered_list) do
    Enum.map(lettered_list, &apply_tense_to_verbs/1)
  end

  defp apply_tense_to_verbs(%{part_of_speech: "verb"} = map) do
    Map.put(map, :tense, get_random_tense())
  end

  defp apply_tense_to_verbs(map) do
    map
  end

  defp get_random_tense() do
    Enum.random(["past", "present"])
  end
end
