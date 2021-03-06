defmodule Assignment.HistoryKeeperWorkerSupervisor do

  use Supervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start_child(pair) do
    spec = %{
      id: pair,
      start: {Assignment.HistoryKeeperWorker, :start_link,  [[pair: pair]]},
      restart: :transient
    }
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
  def start_child(pair, hist, fra) do
    spec = %{
      id: pair,
      start: {Assignment.HistoryKeeperWorker, :start_link,
      [[pair: pair, history: hist, frames: fra]]},
      restart: :transient
    }
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

end
