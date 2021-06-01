defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <h1>Send Your Promo Code to a Friend</h2>

      <h4>
        Enter your friend's promo email below and we'll send them a promo code for 10% off their first game purchase!
      </h4>
    """
  end
end
