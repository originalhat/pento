defmodule Pento.Accounts.UserNotifier do
  import Bamboo.Email

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    new_email(to: user.email, from: "noreply@pento.io", text_body: """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """) |> Pento.Mailer.deliver_now!()
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    new_email(to: user.email, from: "noreply@pento.io", text_body: """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """) |> Pento.Mailer.deliver_now!()
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    new_email(to: user.email, from: "noreply@pento.io", text_body: """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """) |> Pento.Mailer.deliver_now!()
  end
end
