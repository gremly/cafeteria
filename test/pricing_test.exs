defmodule Cafeteria.PricingTest do
  use ExUnit.Case
  doctest Cafeteria

  alias Cafeteria.Coin
  alias Cafeteria.Pricing
  alias Cafeteria.Product

  describe "get_discounts/2" do
    test "no discounts for the given product" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: %Coin{amount: 3.11, currency: :GBP}
      }

      assert %Coin{amount: 0, currency: :GBP} == Pricing.get_discounts(product, 3, %{})
    end

    test "apply pay 1 get 2 discount" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: %Coin{amount: 3.11, currency: :GBP}
      }

      pricing_rules = %{"GR1" => %{type: :free_items, pay: 1, get: 1}}

      assert %Coin{amount: 0.0, currency: :GBP} = Pricing.get_discounts(product, 1, pricing_rules)

      assert %Coin{amount: 3.11, currency: :GBP} =
               Pricing.get_discounts(product, 2, pricing_rules)

      assert %Coin{amount: 6.22, currency: :GBP} =
               Pricing.get_discounts(product, 5, pricing_rules)

      assert %Coin{amount: 18.66, currency: :GBP} =
               Pricing.get_discounts(product, 12, pricing_rules)
    end

    test "apply bulk_fixed discount" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: %Coin{amount: 5.00, currency: :GBP}
      }

      pricing_rules = %{"SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: 4.50}}

      assert %Coin{amount: 1.50, currency: :GBP} ==
               Pricing.get_discounts(product, 3, pricing_rules)
    end

    test "apply bulk_fixed discount for minimum quantity" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: %Coin{amount: 5.00, currency: :GBP}
      }

      pricing_rules = %{"SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: 4.50}}

      assert %Coin{amount: 0.00, currency: :GBP} ==
               Pricing.get_discounts(product, 2, pricing_rules)
    end

    test "apply bulk_percentage discount" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: %Coin{amount: 5.00, currency: :GBP}
      }

      pricing_rules = %{"SR1" => %{type: :bulk_percentage, min_quantity: 3, percentage: 0.1}}

      assert %Coin{amount: 1.50, currency: :GBP} ==
               Pricing.get_discounts(product, 3, pricing_rules)
    end

    test "apply bulk_percentage discount for minimum quantity" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: %Coin{amount: 5.00, currency: :GBP}
      }

      pricing_rules = %{"SR1" => %{type: :bulk_percentage, min_quantity: 3, new_price: 4.50}}

      assert %Coin{amount: 0.00, currency: :GBP} ==
               Pricing.get_discounts(product, 2, pricing_rules)
    end
  end
end
