defmodule Timemanager.WorkingTimes.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime, null: false
    field :start, :naive_datetime, null: false
    field :user_id, :id, null: false

    timestamps()

  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end])
  end
end
