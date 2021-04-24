defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, score: 0, message: "Guess a number.")
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>

    <button phx-click="reset-score">Reset score</button>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    guess = String.to_integer(guess)
    actual = Enum.random(1..10)
    is_correct = correct_score?(guess, actual)

    {
      :noreply,
      assign(socket,
        message: next_message(is_correct, guess),
        score: next_score(is_correct, socket)
      )
    }
  end

  def handle_event("reset-score", _params, socket) do
    {:noreply, assign(socket, message: "Guess a number.", score: 0)}
  end

  defp correct_score?(guess, actual), do: guess == actual

  defp next_message(true, guess), do: "Your guess: #{guess}. Right. Guess again."
  defp next_message(false, guess), do: "Your guess: #{guess}. Wrong. Guess again."

  defp next_score(true, socket), do: socket.assigns.score + 1
  defp next_score(false, socket), do: socket.assigns.score - 1
end
