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
        price: Coin.new("3.11")
      }

      assert Pricing.get_discounts(product, 3, %{}) == Coin.new("0")
    end

    test "apply pay 1 get 2 discount" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: Coin.new("3.11")
      }

      pricing_rules = %{"GR1" => %{type: :free_items, pay: 1, get: 1}}

      assert Pricing.get_discounts(product, 1, pricing_rules) == Coin.new("0.00")
      assert Pricing.get_discounts(product, 2, pricing_rules) == Coin.new("3.11")
      assert Pricing.get_discounts(product, 5, pricing_rules) == Coin.new("6.22")
      assert Pricing.get_discounts(product, 12, pricing_rules) == Coin.new("18.66")
    end

    test "apply bulk_fixed discount" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: Coin.new("5.00")
      }

      pricing_rules = %{
        "SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: Coin.new("4.50")}
      }

      assert Pricing.get_discounts(product, 3, pricing_rules) == Coin.new("1.50")
    end

    test "apply bulk_fixed discount for minimum quantity" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: Coin.new("5.00")
      }

      pricing_rules = %{
        "SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: Coin.new("4.50")}
      }

      assert Pricing.get_discounts(product, 2, pricing_rules) == Coin.new("0")
    end

    test "apply bulk_rate discount" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: Coin.new("5.00")
      }

      pricing_rules = %{"SR1" => %{type: :bulk_rate, min_quantity: 3, rate: 0.1}}
      assert Pricing.get_discounts(product, 3, pricing_rules) == Coin.new("1.50")
    end

    test "apply bulk_percentage discount for minimum quantity" do
      product = %Product{
        code: "SR1",
        name: "Strawberries",
        price: Coin.new("5.00")
      }

      pricing_rules = %{
        "SR1" => %{type: :bulk_percentage, min_quantity: 3, new_price: Decimal.new("4.50")}
      }

      assert Pricing.get_discounts(product, 2, pricing_rules) == Coin.new("0")
    end
  end
end
