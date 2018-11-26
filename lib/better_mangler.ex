defmodule BetterMangler do
  @moduledoc """
  BetterMangler takes an acronym and creates a fake and funny definition.
  """

  @doc """
  
  """
  def start_link() do
    { :ok, pid } = DynamicSupervisor.start_child(BetterMangler.Supervisor, BetterMangler.Server)
    pid
  end

  @doc """
  
  """
  def mangle(pid, word) do 
    GenServer.call(pid, { :mangle, word })
  end
end
