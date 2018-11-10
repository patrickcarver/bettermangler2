defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  alias BetterMangler.SentenceTemplate

  def mangle(word) do
    letters = String.codepoints(word)
    
    template = get_template(letters)

    updated_template = 
      Enum.zip(letters, template)
      |> Enum.map(fn {letter, part_of_speech} -> %{letter: letter, part_of_speech: part_of_speech} end)
      |> Enum.map(&apply_tense_to_verbs/1)


#    updated_template = Enum.map(template, &assign_noun_plurality/1)
    
    {:ok, updated_template}
  end

  defp get_template(letters) do
    letters
    |> Enum.count()
    |> SentenceTemplate.get_random_by_size()    
  end

  defp apply_tense_to_verbs(%{part_of_speech: "verb"} = map) do
    Map.put(map, :tense, get_random_tense())
  end
  
  defp apply_tense_to_verbs(map) do
    map
  end

  defp get_random_plurality() do
    Enum.random(["singular", "plural"])
  end

  defp get_random_tense() do
    Enum.random(["past", "present"])
  end
end
