defmodule DemoWeb.Bad do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <%= @now %>
    <form>
    <input type="text" />
    <select>
      <option>A</option>
      <option>B</option>
    </select>
    </form>
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
