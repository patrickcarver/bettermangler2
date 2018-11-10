defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  alias BetterMangler.Template.{
    LetteredList, PartsOfSpeechList, PluralityAppliedList, TenseAppliedList, WordedList
  }

  alias BetterMangler.Grammar.Handler
  alias RandomWordService

  def start() do
    RandomWordService.init()
  end

  def mangle(word) do
    letters = String.codepoints(word)
    parts_of_speech_list = PartsOfSpeechList.generate(letters)

    updated_template = 
      LetteredList.generate(letters, parts_of_speech_list)
      |> TenseAppliedList.generate()
      |> PluralityAppliedList.generate()
      |> WordedList.generate(RandomWordService)

    {:ok, updated_template}
  end
end
