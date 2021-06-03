defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view

  alias Pento.Search

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_changeset()}
  end

  def assign_changeset(socket) do
    # this doesn't work how I think
    # seems to be similar to promo_live
    socket |> assign(:changeset, Search.changeset(%Search{}, %{}))
  end

  def handle_event("validate", %{"search" => search_params}, socket) do
    changeset =
      %Search{}
      |> Search.changeset(search_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  def render(assigns) do
    ~L"""
      <h1>Search by SKU</h1>

      <%= f = form_for @changeset, "#",
        id: "promo-form",
        phx_change: "validate",
        phx_submit: "save" %>

        <%= label f, :sku %>
        <%= text_input f, :sku, phx_debounce: "blur" %>
        <%= error_tag f, :sku %>

        <%= submit "Search", phx_disable_with: "Searching..." %>
    """
  end
end
