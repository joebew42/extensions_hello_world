defmodule ExtensionsHelloWorld.UseCases.ChangeColor do
  @behaviour ExtensionsHelloWorld.UseCase

  @user_is_in_cool_down   "user is in cool down"
  @user_is_changing_color "user is changing color"

  alias ExtensionsHelloWorld.User
  alias ExtensionsHelloWorld.MockUsers, as: Users
  alias ExtensionsHelloWorld.MockCoolDown, as: CoolDown

  alias ExtensionsHelloWorld.Channel
  alias ExtensionsHelloWorld.MockChannels, as: Channels
  alias ExtensionsHelloWorld.MockColorPicker, as: ColorPicker

  alias ExtensionsHelloWorld.MockPublisher, as: Publisher

  @impl true
  def run_with(channel_id: channel_id, user_id: user_id) do
    user = Users.find(user_id)

    case User.cooldown?(user) do
      true ->
        {:error, @user_is_in_cool_down}
      false ->
        # This is about setting the new cooldown for the user
        :ok =
          user
          |> User.set_cooldown(CoolDown.new())
          |> Users.save()

        # This is about setting a new color for the channel
        new_color = ColorPicker.pick()

        :ok =
          %Channel{id: channel_id}
          |> Channel.set_color(new_color)
          |> Channels.save()

        :ok = Publisher.publish(%{ channel_id: channel_id, color: new_color })

        {:ok, @user_is_changing_color}
    end
  end
end