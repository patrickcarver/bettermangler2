defmodule Template.LetteredList do
  @moduledoc """
  
  """

  @doc """
  
  """
  def generate(letters, parts_of_speech_list) do
    create_tuples_to_pair_data(letters, parts_of_speech_list)
    |> create_maps_of_letters_and_parts_of_speech()  
  end

  # is this really clearer than using Enum.zip directly in generate?
  defp create_tuples_to_pair_data(letters, parts_of_speech_list) do
    Enum.zip(letters, parts_of_speech_list)
  end

  # is this really clearer than using Enum.map directly in generate?
  defp create_maps_of_letters_and_parts_of_speech(list_of_tuples) do
    Enum.map(list_of_tuples, &create_map/1)  
  end

  defp create_map({letter, part_of_speech}) do
    %{letter: letter, part_of_speech: part_of_speech}
  end
end