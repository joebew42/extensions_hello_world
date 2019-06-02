ExUnit.start(trace: true, exclude: [:integration])

:ok = Application.start(:mox)
