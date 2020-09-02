defmodule MementoWeb.PassageLive.PassageComponent do
  use MementoWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div style="display: flex; justify-content: space-between; align-items: center;">
      <button phx-click="prev-click">Previous</button>
      <h2>
        <%= @passage.name %>
      </h2>
      <button phx-click="next-click">Next</button>
    </div>
    <div style="display: flex; justify-content: center; align-items: center;">
      <pre><%= @passage.text %></pre>
    </div>
    """
  end
end
