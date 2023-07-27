defmodule Cafeteria.Basket.Test do
  use ExUnit.Case
  doctest Cafeteria

  alias Cafeteria.Basket
  alias Cafeteria.Coin
  alias Cafeteria.Product

  describe "scan/2" do
    test "add products by code to the given basket" do
      {:ok, basket} = Basket.new() |> Basket.scan("GR1")

      assert %Basket{products: [product], status: :open} = basket
      refute is_nil(basket.id)

      assert %Product{code: "GR1", name: "Green tea", price: price} = product
      assert %Coin{amount: 3.11, currency: "GBP"} = price
    end
  end
end
