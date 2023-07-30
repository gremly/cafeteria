defmodule Cafeteria.Pricing do
  alias Cafeteria.Coin

  @doc """
  Return the applicable discount if there is a rule defined to
  the given product and product quantity.

  Three type of pricing rules are supported
  - Pay x get y -> type: free_items
  - Bulk discount with fixed price -> type: bulk_fixed
  - Bulk discount with perctage / rate -> type: bulk_rate
  """
  @spec get_discounts(Product.t(), number(), map()) :: map()
  def get_discounts(product, product_qty, pricing_rules) do
    case pricing_rules[product.code] do
      nil ->
        Coin.new("0")

      rule ->
        apply_pricing_rule(rule, product.price, product_qty)
    end
  end

  # Internal functions

  defp apply_pricing_rule(%{type: :free_items} = rule, price, quantity) do
    for_free = div(quantity, rule.pay + rule.get)
    Coin.mult(for_free, price)
  end

  defp apply_pricing_rule(%{type: :bulk_fixed, min_quantity: min} = rule, price, quantity)
       when min <= quantity do
    price |> Coin.sub(rule.new_price) |> Coin.mult(quantity)
  end

  defp apply_pricing_rule(%{type: :bulk_rate, min_quantity: min} = rule, price, quantity)
       when min <= quantity do
    price |> Coin.mult(rule.rate) |> Coin.mult(quantity)
  end

  defp apply_pricing_rule(_rule, _price, _qty), do: Coin.new("0")
end
