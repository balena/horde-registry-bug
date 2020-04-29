defmodule HordeRegistryBug.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    local_key = NaiveDateTime.utc_now()

    topologies = [
      gossip: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      Janitor,
      {Horde.Registry,
       keys: :unique, name: ClusterRegistry, members: :auto, listeners: [Janitor]},
      {SomeModule, name: {:via, Horde.Registry, {ClusterRegistry, local_key}}},
      {Cluster.Supervisor, [topologies, [name: __MODULE__.Supervisor]]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
