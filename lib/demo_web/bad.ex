defmodule DemoWeb.Bad do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <p>In live view</p>
    <p><%= @now %></p>
    <%= live_component(@socket, FooComponent) do %>
    <p>In component<p>
    <p><%= @now %></p>
    <% end %>
    """
  end

  def mount(_, _, socket) do
    {:ok, tick(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, tick(socket)}
  end

  defp tick(socket) do
    Process.send_after(self(), :tick, 1_000)
    assign(socket, :now, DateTime.utc_now())
  end
end
