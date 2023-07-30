defmodule Cafeteria.PricingTest do
  use ExUnit.Case
  doctest Cafeteria

  alias Cafeteria.Coin
  alias Cafeteria.Pricing
  alias Cafeteria.Product

  describe "get_discounts/2" do
    test "no pricing rules for the given product" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: %Coin{amount: 3.11, currency: "GBP"}
      }

      assert %Coin{amount: 0, currency: "GBP"} == Pricing.get_discounts(product, 3, %{})
    end

    test "apply pay 1 get 2 pricing rule" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: %Coin{amount: 3.11, currency: "GBP"}
      }

      pricing_rules = %{"GR1" => %{type: :free_items, pay: 1, get: 1}}

      assert %Coin{amount: 0.0, currency: "GBP"} =
               Pricing.get_discounts(product, 1, pricing_rules)

      assert %Coin{amount: 3.11, currency: "GBP"} =
               Pricing.get_discounts(product, 2, pricing_rules)

      assert %Coin{amount: 6.22, currency: "GBP"} =
               Pricing.get_discounts(product, 5, pricing_rules)

      assert %Coin{amount: 18.66, currency: "GBP"} =
               Pricing.get_discounts(product, 12, pricing_rules)
    end
  end
end
