defmodule Cafeteria.BasketTest do
  use ExUnit.Case

  alias Cafeteria.Basket
  alias Cafeteria.Coin
  alias Cafeteria.Product

  describe "scan/2" do
    test "add products by code to the given basket" do
      product_code = "GR1"
      {:ok, basket} = Basket.new() |> Basket.scan(product_code)

      assert %Basket{items: %{^product_code => {product, 1}}, status: :open} = basket
      refute is_nil(basket.id)

      assert %Product{code: "GR1", name: "Green tea", price: price} = product
      assert price == Coin.new("3.11")
    end

    test "add two products by code to the given basket" do
      product_code = "GR1"

      {:ok, basket} = Basket.new() |> Basket.scan(product_code)
      {:ok, basket} = basket |> Basket.scan(product_code)

      assert %Basket{items: %{^product_code => {product, 2}}, status: :open} = basket
      assert %Product{code: "GR1", name: "Green tea"} = product
    end
  end
end
