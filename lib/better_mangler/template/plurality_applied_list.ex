defmodule BetterMangler.Template.PluralityAppliedList do
  @moduledoc """

  """

  @doc """

  """
  def generate(tense_applied_list) do
    process_plurality(starting: tense_applied_list, ending: [], last_noun_plurality: nil)
  end

  defp process_plurality(starting: [], ending: plurality_applied_list, last_noun_plurality: _) do
    plurality_applied_list
  end

  defp process_plurality(
         starting: starting,
         ending: ending,
         last_noun_plurality: last_noun_plurality
       ) do
    [map | updated_starting] = starting
    {updated_map, updated_last_noun_plurality} = update_map(map, last_noun_plurality)
    updated_ending = ending ++ [updated_map]

    process_plurality(
      starting: updated_starting,
      ending: updated_ending,
      last_noun_plurality: updated_last_noun_plurality
    )
  end

  defp update_map(%{part_of_speech: "noun"} = map, _last_noun_plurality) do
    updated_last_noun_plurality = get_random_plurality()
    updated_map = Map.put(map, :plurality, updated_last_noun_plurality)
    {updated_map, updated_last_noun_plurality}
  end

  defp update_map(%{part_of_speech: "verb", tense: "present"} = map, last_noun_plurality) do
    updated_last_noun_plurality = update_last_noun_plurality(last_noun_plurality)

    updated_map = Map.put(map, :plurality, updated_last_noun_plurality)
    {updated_map, last_noun_plurality}
  end

  defp update_map(map, last_noun_plurality) do
    {map, last_noun_plurality}
  end

  defp update_last_noun_plurality(last_noun_plurality) do
    case last_noun_plurality do
      nil -> get_random_plurality()
      _ -> last_noun_plurality
    end
  end

  defp get_random_plurality() do
    Enum.random(["singular", "plural"])
  end
end
