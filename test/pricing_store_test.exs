defmodule Cafeteria.PricingStoreTest do
  use ExUnit.Case

  alias Cafeteria.PricingStore

  describe "add_discount_rule/2" do
    test "creates a new discount rule for a product" do
      rule = %{type: :free_items, pay: 1, get: 1}
      assert {:ok, %{"GR1" => ^rule}} = PricingStore.add_discount_rule(%{}, "GR1", rule)
    end

    test "fails if product does not exist" do
      rule = %{type: :free_items, pay: 1, get: 1}
      assert {:error, :product_not_found} = PricingStore.add_discount_rule(%{}, "AA11", rule)
    end
  end

  describe "get_discount_rules/1" do
    test "existent discount rules retrieval" do
      rules = PricingStore.get_discount_rules()

      assert rules |> Map.keys() |> length() == 3
    end
  end
end
