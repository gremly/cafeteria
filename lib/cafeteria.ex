defmodule Cafeteria do
  @moduledoc """
  Application public API to be used
  by outer layers of the system.
  """

  alias Cafeteria.Basket
  alias Cafeteria.Coin

  @spec basket_create() :: {:ok, Basket.t()}
  def basket_create() do
    Basket.new()
  end

  @spec scan_product(Basket.t(), String.t()) :: {:ok, Basket.t()} | {:error, atom()}
  def scan_product(basket, product_code) do
    Basket.scan(basket, product_code)
  end

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
