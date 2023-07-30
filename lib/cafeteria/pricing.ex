defmodule Cafeteria.Pricing do
  alias Cafeteria.Coin

  @doc """
  Return the applicable discount if there is a rule defined to
  the given product and product quantity.
  """
  @spec get_discounts(Product.t(), number(), map()) :: map()
  def get_discounts(product, product_qty, pricing_rules) do
    case pricing_rules[product.code] do
      nil ->
        %Coin{amount: 0, currency: product.price.currency}

      rule ->
        apply_pricing_rule(rule, product.price, product_qty)
    end
  end

  # Internal functions

  defp apply_pricing_rule(%{type: :free_items} = rule, price, quantity) do
    for_free = div(quantity, rule.pay + rule.get)
    amount = for_free * price.amount
    %Coin{amount: amount, currency: price.currency}
  end

  defp apply_pricing_rule(%{type: :bulk_fixed, min_quantity: min} = rule, price, quantity)
       when min <= quantity do
    amount = (price.amount - rule.new_price) * quantity
    %Coin{amount: amount, currency: price.currency}
  end

  defp apply_pricing_rule(%{type: :bulk_percentage, min_quantity: min} = rule, price, quantity)
       when min <= quantity do
    amount = price.amount * rule.percentage * quantity
    %Coin{amount: amount, currency: price.currency}
  end

  defp apply_pricing_rule(_, price, _), do: %Coin{amount: 0.0, currency: price.currency}
end
