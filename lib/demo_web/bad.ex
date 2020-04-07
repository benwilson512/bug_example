defmodule DemoWeb.Bad do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="update" phx-disable-with="Saving...">
    <input type="text" name="text" value="<%= @text %>">
    </form>
    """
  end

  def mount(_, _, socket) do
    {:ok, assign(socket, :text, "")}
  end

  def handle_event("update", %{"text" => text}, socket) do
    {:noreply, assign(socket, :text, text)}
  end
end
