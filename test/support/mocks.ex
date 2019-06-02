alias ExtensionsHelloWorld.Model

Mox.defmock(ExtensionsHelloWorld.MockTokenAuthenticator, for: Model.TokenAuthenticator)
Mox.defmock(ExtensionsHelloWorld.MockUseCase, for: Model.UseCase)
Mox.defmock(ExtensionsHelloWorld.MockUsers, for: Model.Users)
Mox.defmock(ExtensionsHelloWorld.MockCoolDown, for: Model.CoolDown)
Mox.defmock(ExtensionsHelloWorld.MockChannels, for: Model.Channels)
Mox.defmock(ExtensionsHelloWorld.MockColorPicker, for: Model.ColorPicker)
Mox.defmock(ExtensionsHelloWorld.MockPublisher, for: Model.Publisher)