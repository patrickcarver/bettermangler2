defmodule BetterMangler.Template.PartsOfSpeechList do
  @moduledoc """

  """

  alias Poison

  @doc """

  """
  def generate(letter_list) do
    letter_list
    |> Enum.count()
    |> get_random_by_size()
  end

  defp get_random_by_size(size) do
    # maybe template should have integer for key instead of string?
    "../../../json/sentence_templates.json"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> Poison.decode!()
    |> Map.get(Integer.to_string(size))
    |> Enum.random()
  end
end
