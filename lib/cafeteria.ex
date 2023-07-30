defmodule Cafeteria do
  @moduledoc """
  Application public API to be used
  by outer layers of the system.
  """

  alias Cafeteria.Basket
  alias Cafeteria.Coin

  @doc """
  The process of checking out an open basket involves
  calculating the net price of the purchase, which
  is the gross price minus the discounts that may apply.

  A custom type `Coin` is returned which has the amount
  and currency of the transaction.
  """
  @spec basket_checkout(Basket.t(), map()) :: Coin.t()
  def basket_checkout(basket, discount_rules) do
    Basket.checkout(basket, discount_rules)
  end
end
