defmodule BetterMangler.Template.WordedList do
  @moduledoc """

  """

  @doc """

  """
  def generate(plurality_applied_list, random_word_function) do
    Enum.map(plurality_applied_list, fn map ->
      word = get_random_word(map.letter, map.part_of_speech, random_word_function)

      map
      |> Map.put(:word, word)
      |> Map.delete(:letter)
    end)
  end

  defp get_random_word(letter, part_of_speech, random_word_function) do
    {:ok, word} =
      random_word_function.(starts_with: letter, part_of_speech: part_of_speech)

    word
  end
end
