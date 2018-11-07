defmodule BetterMangler.SentenceTemplate do
  @moduledoc """
  
  """

  alias Poison

  @doc """
  
  """
  def get_random_by_size(size) do
    "../../json/sentence_templates.json"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> Poison.decode!()
    |> Map.get(Integer.to_string(size))
    |> Enum.random()
  end
end