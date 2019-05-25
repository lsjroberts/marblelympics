defmodule Marbles.Repo do
  use Ecto.Repo, otp_app: :marbles

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
    # {:ok, Keyword.put(opts, :url, "postgresql://localhost/marbles")}
  end
end
