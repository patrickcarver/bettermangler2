defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  alias BetterMangler.SentenceTemplate
  alias RandomWordService

  def mangle(word) do
    RandomWordService.init()

    letters = String.codepoints(word)
    
    template = get_template(letters)

    updated_template = 
      Enum.zip(letters, template)
      |> Enum.map(fn {letter, part_of_speech} -> %{letter: letter, part_of_speech: part_of_speech} end)
      |> Enum.map(&apply_tense_to_verbs/1)
      |> apply_plurality()
      |> Enum.map(fn map -> 
        {:ok, word } = RandomWordService.get_random_word(starts_with: map.letter, part_of_speech: map.part_of_speech) 
        map
        |> Map.put(:word, word)
        |> Map.delete(:letter)
      end)
    
    {:ok, updated_template}
  end

  defp apply_plurality(template) do
    process_plurality(starting: template, ending: [], last_noun_plurality: nil)
  end

  defp process_plurality(starting: [], ending: ending, last_noun_plurality: _) do
    ending
  end

  defp process_plurality(starting: starting, ending: ending, last_noun_plurality: last_noun_plurality) do
    [map | updated_starting] = starting
    {updated_map, updated_last_noun_plurality} = update_map(map, last_noun_plurality)
    updated_ending = ending ++ [updated_map]
    process_plurality(starting: updated_starting, ending: updated_ending, last_noun_plurality: updated_last_noun_plurality)
  end

  defp update_map(%{part_of_speech: "adverb"} = map, last_noun_plurality) do
    { map, last_noun_plurality }
  end

  defp update_map(%{part_of_speech: "adjective"} = map, last_noun_plurality) do
    { map, last_noun_plurality }
  end

  defp update_map(%{part_of_speech: "noun"} = map, _last_noun_plurality) do
    updated_last_noun_plurality = get_random_plurality()
    updated_map = Map.put(map, :plurality, updated_last_noun_plurality)
    { updated_map, updated_last_noun_plurality}
  end  

  defp update_map(%{part_of_speech: "verb", tense: "past"} = map, last_noun_plurality) do
    { map, last_noun_plurality}
  end

  defp update_map(%{part_of_speech: "verb", tense: "present"} = map, last_noun_plurality) do
    updated_last_noun_plurality = case last_noun_plurality do
                                    nil -> get_random_plurality()
                                    _ -> last_noun_plurality
                                  end

    updated_map = Map.put(map, :plurality, updated_last_noun_plurality)
    { updated_map, last_noun_plurality}
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
