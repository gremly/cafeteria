defmodule Cafeteria.Coin do
  @enforce_keys [:amount, :currency]
  defstruct amount: 0, currency: "GBP"
end
