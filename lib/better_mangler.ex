defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  alias BetterMangler.Template.{
    LetteredList,
    PartsOfSpeechList,
    PluralityAppliedList,
    TenseAppliedList,
    WordedList
  }

  alias BetterMangler.WordPlurality
  alias RandomWordService

  def start() do
    RandomWordService.init()
  end

  def mangle(word) do
    letters = String.codepoints(word)
    parts_of_speech_list = PartsOfSpeechList.generate(letters)

    definition =
      LetteredList.generate(letters, parts_of_speech_list)
      |> TenseAppliedList.generate()
      |> PluralityAppliedList.generate()
      |> WordedList.generate(RandomWordService)
      |> WordPlurality.handle_list()
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(" ")

    {:ok, definition}
  end
end
