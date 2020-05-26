defmodule BigBrother.Application do
  alias BigBrother.Actor
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "Big Brother is Watching!"
    children = [cspec(:julia), cspec(:winston), cspec(:syme)]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: BigBrother.Supervisor]
    Supervisor.start_link(children, opts)
  end
  
  defp cspec(character_name) do
    %{
      id: character_name,
      start: {Actor, :start_link, [character_name]}
    }
  end
end
