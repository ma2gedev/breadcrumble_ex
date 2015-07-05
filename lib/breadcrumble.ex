defmodule Breadcrumble do
  defmacro __using__(_) do
    quote do
      import Breadcrumble.Plugs
    end
  end
end
