defmodule ExtensionsHelloWorld.UseCases.ChangeColor do
  @behaviour ExtensionsHelloWorld.UseCase

  @user_is_in_cool_down   "user is in cool down"
  @user_is_changing_color "user is changing color"

  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.Channel

  @impl true
  def run_with(channel_id: channel_id, user_id: user_id) do
    user = users().find(user_id)

    case User.cooldown?(user) do
      true ->
        {:error, @user_is_in_cool_down}
      false ->
        # This is about setting the new cooldown for the user
        :ok =
          user
          |> User.set_cooldown(cooldown().new())
          |> users().save()

        # This is about setting a new color for the channel
        new_color = color_picker().pick()

        :ok =
          %Channel{id: channel_id}
          |> Channel.set_color(new_color)
          |> channels().save()

        :ok = publisher().publish(%{ channel_id: channel_id, color: new_color })

        {:ok, @user_is_changing_color}
    end
  end

  defp users() do
    Application.get_env(:extensions_hello_world, :users)
  end

  defp cooldown() do
    Application.get_env(:extensions_hello_world, :cooldown)
  end

  defp color_picker() do
    Application.get_env(:extensions_hello_world, :color_picker)
  end

  defp channels() do
    Application.get_env(:extensions_hello_world, :channels)
  end

  defp publisher() do
    Application.get_env(:extensions_hello_world, :publisher)
  end
end