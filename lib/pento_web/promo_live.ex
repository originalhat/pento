defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_recipient() |> assign_changeset()}
  end

  def assign_recipient(socket) do
    socket |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket |> assign(:changeset, Promo.change_recipient(recipient))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient |> Promo.change_recipient(recipient_params) |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"recipient" => recipient_params}, socket) do
    case Promo.send_promo(socket.assigns.recipient, recipient_params) do
      {:ok, _recipient} ->
        {:noreply,
         socket
         |> put_flash(:info, "Promo sent successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
  def render(assigns) do
    ~L"""
      <h1>Send Your Promo Code to a Friend</h2>

      <h4>
        Enter your friend's promo email below and we'll send them a promo code for 10% off their first game purchase!
      </h4>

      <%= f = form_for @changeset, "#",
        id: "promo-form",
        phx_change: "validate",
        phx_submit: "save" %>

        <%= label f, :first_name %>
        <%= text_input f, :first_name %>
        <%= error_tag f, :first_name %>

        <%= label f, :email %>
        <%= text_input f, :email %>
        <%= error_tag f, :email %>

        <%= submit "Send promo" %>
    """
  end
end
