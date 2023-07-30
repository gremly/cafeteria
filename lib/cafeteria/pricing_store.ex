defmodule Cafeteria.PricingStore do
  @moduledoc """
  Basic storage to manage discount rules dinamically.
  It might need to be extended to use an external storage system
  like a DB.
  """

  alias Cafeteria.Coin
  alias Cafeteria.Product
  alias Cafeteria.Store

  # NOTE: Will be removed once an external storage gets implemented
  @discount_rules %{
    "GR1" => %{type: :free_items, pay: 1, get: 1},
    "SR1" => %{type: :bulk_fixed, min_quantity: 3, new_price: Coin.new("4.50")},
    "CF1" => %{type: :bulk_rate, min_quantity: 3, rate: 1 - 2 / 3}
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
