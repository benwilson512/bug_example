defmodule DemoWeb.Bad do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="change" phx-submit="submit">
    <label>
    check me
    <input type="checkbox" value="true" <%= if @checked, do: "checked" %> name="foo">
    </label>
    <button type="submit">Submit</button>
    </form>
    """
  end

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(:checked, false)

    {:ok, socket}
  end

  def handle_event("change", params, socket) do
    params |> IO.inspect(label: :phx_change)

    socket =
      if params["foo"] == "true" do
        assign(socket, :checked, true)
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_event("submit", params, socket) do
    params |> IO.inspect(label: :phx_submit)
    socket = assign(socket, :checked, false)
    {:noreply, socket}
  end
end
