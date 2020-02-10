defmodule DemoWeb.Bad do
  use Phoenix.LiveView
  use Phoenix.HTML

  defmodule Data do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :selected, :string
    end

    def changeset(data \\ %__MODULE__{}, params) do
      data |> cast(params, [:selected])
    end
  end

  def render(assigns) do
    ~L"""
    <%= @now %>
    <%= f = form_for @changeset, "#", [phx_change: "change", phx_submit: "submit", csrf_token: false] %>
    <%= select f, :selected, ["A": "A", "B": "B", "C": "C"] %>
    </form>
    """
  end

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(:changeset, Data.changeset(%{selected: "A"}))
      |> tick

    {:ok, socket}
  end

  def handle_event("change", %{"data" => params}, socket) do
    params |> IO.inspect(label: :phx_change)

    socket =
      socket
      |> assign(:changeset, Data.changeset(params))

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

  def handle_info(:tick, socket) do
    {:noreply, tick(socket)}
  end

  defp tick(socket) do
    Process.send_after(self(), :tick, 1_000)
    assign(socket, :now, DateTime.utc_now())
  end
end
