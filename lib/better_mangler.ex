defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  alias BetterMangler.SentenceTemplate

  def mangle(word) do
    letters = String.codepoints(word)
    
    template = get_template(letters)
    
    {:ok, template}
  end

  defp get_template(letters) do
    letters
    |> Enum.count()
    |> SentenceTemplate.get_random_by_size()    
  end
end
