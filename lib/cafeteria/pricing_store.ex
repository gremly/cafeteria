defmodule Cafeteria.PricingStore do
  @moduledoc """
  Basic storage to manage discount rules dinamically.
  It might need to be extended to use an external store system
  like a DB.
  """

  alias Cafeteria.Product
  alias Cafeteria.Store

  @discount_rules %{
    "GR1" => %{type: :free_items, pay: 1, get: 1},
    "SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: 4.50},
    # NOTE: s/percentage/fraction ?
    "CF1" => %{type: :bulk_percentage, min_quantity: 3, percentage: 1 - 2 / 3}
  }

  @doc """
  Add or update a discount rule to the given product, failing
  if the product does not exist
  """
  @spec add_discount_rule(map(), String.t(), map()) :: {:ok, map()} | {:error, :product_not_found}
  def add_discount_rule(pricing_rules, product_code, rule) do
    with {:ok, %Product{}} <- Store.get_product(product_code) do
      {:ok, Map.put(pricing_rules, product_code, rule)}
    end
  end

  @spec get_discount_rules() :: map()
  def get_discount_rules() do
    @discount_rules
  end
end
