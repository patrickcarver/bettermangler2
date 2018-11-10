defmodule BetterMangler.Template.WordedList do
  @moduledoc """
  
  """

  @doc """
  
  """
  def generate(plurality_applied_list, word_service) do
    Enum.map(fn map -> 
      word = get_random_word(map.letter, map.part_of_speech, word_service)

      map
      |> Map.put(:word, word)
      |> Map.delete(:letter)
    end)    
  end

  defp get_random_word(letter, part_of_speech, word_service) do
    {:ok, word } = word_service.get_random_word(starts_with: letter, part_of_speech: part_of_speech)
    word
  end
end