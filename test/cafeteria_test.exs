defmodule CafeteriaTest do
  use ExUnit.Case
  doctest Cafeteria

  alias Cafeteria.Basket
  alias Cafeteria.Coin
  alias Cafeteria.PricingStore

  describe "basket_checkout/1" do
    test "checkout basket eligible to green tee (GR1) discount" do
      discount_rules = PricingStore.get_discount_rules()
      product_codes = ["GR1", "SR1", "GR1", "GR1", "CF1"]

      basket =
        Enum.reduce(product_codes, Basket.new(), fn product_code, basket ->
          {:ok, basket} = Basket.scan(basket, product_code)
          basket
        end)

      assert Cafeteria.basket_checkout(basket, discount_rules) == Coin.new("22.45", :GBP)
    end
  end
end
