defmodule FooComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
    <div>
    <%= @inner_content.(assigns) %>
    </div>
    """
  end
end
