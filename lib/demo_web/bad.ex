defmodule DemoWeb.Bad do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="change" phx-submit="submit">
    <select>
      <option value="a">A</option>
      <option value="b">B</option>
      <option value="c">C</option>
    </select>
    <button type="submit">Invert</button>
    </form>
    """
  end

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(:check1, true)
      |> assign(:check2, false)

    {:ok, socket}
  end

  def handle_event("change", params, socket) do
    params |> IO.inspect(label: :phx_change)

    socket =
      Enum.reduce(["check1", "check2"], socket, fn param, socket ->
        if params[param] == "true" do
          # lol
          assign(socket, String.to_atom(param), true)
        else
          assign(socket, String.to_atom(param), false)
        end
      end)

    {:noreply, socket}
  end

  def handle_event("submit", params, socket) do
    # on submit, we invert the current check state.
    socket =
      socket
      |> update(:check1, &(!&1))
      |> update(:check2, &(!&1))

    {:noreply, socket}
  end
end
