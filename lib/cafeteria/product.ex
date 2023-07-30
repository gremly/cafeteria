defmodule Cafeteria.Product do
  alias Cafeteria.Coin

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          price: Coin.t()
        }

  defstruct [:code, :name, :price]
end
