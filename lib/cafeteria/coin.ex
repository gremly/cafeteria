defmodule Cafeteria.Coin do
  @type t :: %__MODULE__{
          amount: number(),
          currency: atom()
        }

  @enforce_keys [:amount]
  defstruct amount: 0, currency: :GBP
end
