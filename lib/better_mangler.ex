defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """
  
  def run(acronym) do
    %{"nouns" => nouns} = load_json("../txt/nouns.json")
    list = String.codepoints(acronym)    

    {:ok, list}
  end

  defp load_json(file) do
    file
    |> Path.expand(__DIR__)
    |> File.read!()
    |> Poison.decode!()
  end


end
