defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """


  def start_link() do
    { :ok, pid } = DynamicSupervisor.start_child(BetterMangler.Supervisor, BetterMangler.Server)
    pid
  end

  def mangle(pid, word) do 
    GenServer.call(pid, { :mangle, word })
  end

#  def mangle(word) do
#    letters = String.codepoints(word)
#    parts_of_speech_list = PartsOfSpeechList.generate(letters)

#    definition =
#      LetteredList.generate(letters, parts_of_speech_list)
#      |> TenseAppliedList.generate()
#      |> PluralityAppliedList.generate()
#      |> WordedList.generate()
#      |> WordPlurality.handle_list()
#      |> Enum.map(&String.capitalize/1)
#      |> Enum.join(" ")

#    {:ok, definition}
 # end
end
