# ExtensionsHelloWorld

An example of a [Twitch Extension](https://dev.twitch.tv/docs/extensions/) written in Elixir.

It is a port from the original [Extensions-Hello-World](https://github.com/twitchdev/extensions-hello-world).

## Setup

```
mix deps.get
```

## Tests

```
mix test
```

## Notes

signer = Joken.Signer.create("HS256", "secret")

{:ok, token, _} = Joken.encode_and_sign(%{"hello" => "world"}, signer)

{:error, :signature_error} | {:ok, %{"hello" => "world"} = payload} = Joken.verify_and_validate(%{}, token, signer)