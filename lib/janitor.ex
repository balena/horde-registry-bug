defmodule Janitor do
  use GenServer

  require Logger

  @doc false
  def start_link(args),
    do: GenServer.start_link(__MODULE__, args, name: __MODULE__)

  @impl true
  def init(_), do: {:ok, []}

  @impl true
  def handle_info({:register, _registry, _key, pid, _value} = msg, state) do
    Logger.info("#{inspect msg}")

    Process.monitor(pid)

    {:noreply, state}
  end

  def handle_info({:unregister, _registry, _key, _pid} = msg, state) do
    Logger.info("#{inspect msg}")

    {:noreply, state}
  end

  def handle_info({:DOWN, _ref, _type, pid, reason} = msg, state) do
    Logger.info("#{inspect msg}")

    Kernel.send(ClusterRegistry, {:EXIT, pid, reason})

    {:noreply, state}
  end
end
