defmodule SomeModule do
  use GenServer

  @doc false
  def start_link(args),
    do: GenServer.start_link(__MODULE__, [], name: Keyword.fetch!(args, :name))

  @impl true
  def init(state), do: {:ok, state}
end
