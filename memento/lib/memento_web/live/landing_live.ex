defmodule MementoWeb.LandingLive do
  use MementoWeb, :live_view
  alias Memento.Picker

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        passage_id: Picker.first()
      )
      |> load_passage
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome!</h1>

    <%= live_component(@socket, MementoWeb.PassageLive.PassageComponent, id: "picker", passage: @passage) %>
    <div style="display: flex; justify-content: center; align-items: center;">
      <button phx-click="select-click">Select</button>
    </div>
    """
  end

  defp load_passage(socket) do
    assign(socket, passage: Picker.passage(socket.assigns.passage_id))
  end

  defp previous_id(socket) do
    assign(socket, passage_id: Picker.previous(socket.assigns.passage_id))
  end

  defp next_id(socket) do
    assign(socket, passage_id: Picker.next(socket.assigns.passage_id))
  end

  def handle_event("prev-click", _meta, socket) do
    {
      :noreply,
      socket
      |> previous_id
      |> load_passage
    }
  end

  def handle_event("next-click", _meta, socket) do
    {
      :noreply,
      socket
      |> next_id
      |> load_passage
    }
  end

  def handle_event("select-click", _meta, socket) do
    {:noreply, push_redirect(socket, to: "/erase/#{socket.assigns.passage_id}")}
  end
end
