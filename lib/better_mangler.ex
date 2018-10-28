defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """
  
  def run(acronym) do
    list = String.codepoints(acronym)
    {:ok, list}
  end


end
